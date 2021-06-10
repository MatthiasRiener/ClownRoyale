import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
     var manager : SocketManager?
     var socket : SocketIOClient?
     var users = [NSDictionary]()
     var roomID : String?
     var userID: String?
     var currentCat: NSDictionary = [:]
     var usersVoted = [NSDictionary]()

     override init() {
         super.init()
     }

     func createSocketConnection (completionHandler: @escaping (_ connected: Bool) -> Void) {
         manager = SocketManager(socketURL: URL(string: "ws://localhost:5000")!
            ,config: [.log(false)])

         socket = manager?.defaultSocket

         socket?.on(clientEvent: .connect) { data, ack in
             completionHandler(true)
         }
         socket?.connect()
     }

     func closeConnection() {
         socket?.disconnect()
     }

     func joinLobby() {
        sendRequestToServer(url: "/user/getUID", method: "GET")?
        .then { data in
            //print("Id: \(data["u_id"]!)")
            self.userID = "\(data["u_id"]!)"
            self.socket?.emit("joinLobbyRequest", ["u_id": "\(data["u_id"]!)"])
        }
     }

    func joinLobbyResponse(completionHandler: @escaping (_ status: Int) -> Void) {
         socket?.on("joinLobbyResponse") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                let status = responseData.value(forKey: "status") as! Int 
                self.roomID = responseData.value(forKey: "lobbyID") as! String
                self.users = responseData.value(forKey: "users") as! Array<NSDictionary>
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                print("JOIN LOBBY RESPONSE")
                print(responseData)
                
                //MainViewController.sharedInstance.lobbyReady(status: status)
                /*if let topController = UIApplication.topViewController() {
                    topController.performSegue(withIdentifier: "play", sender: topController)
                }*/
                //completionHandler(status)
            }
         }
     }
    
    func successJoin(completionHandler: @escaping (_ status: Int) -> Void) {
         socket?.on("successJoin") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                self.roomID = responseData.value(forKey: "lobbyID") as! String
                self.users = responseData.value(forKey: "users") as! Array<NSDictionary>
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                
                print("SUCCESS")
                
                if let topController = UIApplication.topViewController() {
                    topController.performSegue(withIdentifier: "play", sender: topController)
                }
                completionHandler(1)
            }
         }
     }
    
    func newUserHasJoined(completionHandler: @escaping (_ status: Int) -> Void) {
         socket?.on("newUserHasJoined") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                self.users = responseData.value(forKey: "users") as! Array<NSDictionary>
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                print("JOIN LOBBY RESPONSE")
                print(responseData)
            
                completionHandler(1)
            }
         }
     }
    
    func lobbyReadyToStartResponse(completionHandler: @escaping (_ data: NSDictionary) -> Void) {
         socket?.on("lobbyReadyToStartResponse") { data,ack in
            print("lobbyReadyToStartResponse")
            print(data)
            if let responseData = data[0] as? NSDictionary {
                completionHandler(responseData)
                
            }
         }
     }
    
    func userReady() {
        print("USERID")
        self.socket?.emit("userIsReady", ["roomID": self.roomID, "userID": self.userID])
    }
    
    func userReadyResponse(completionHandler: @escaping (_ status: Int) -> Void) {
         socket?.on("userIsReadyResponse") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                let status = responseData.value(forKey: "status") as! Int
                self.users = responseData.value(forKey: "users") as! Array<NSDictionary>
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                completionHandler(status)
            }
         }
     }
    
    func changeStatusOfPlayer(completionHandler: @escaping (_ status: Int) -> Void) {
         socket?.on("changeStatusOfPlayer") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                self.users = responseData.value(forKey: "users") as! Array<NSDictionary>
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                print("JOIN LOBBY RESPONSE")
                print(responseData)
            
                completionHandler(1)
            }
         }
     }
    
    func chooseCategory(cat: String) {
        self.socket?.emit("userChoseCategory", ["roomID": self.roomID, "userID": self.userID, "catID": cat]);
     }
    
    func chooseCategoryRespone(completionHandler: @escaping (_ status: NSDictionary) -> Void) {
         socket?.on("userDecidedToClickOnCategoryThanksEveryone") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                self.currentCat = responseData.value(forKey: "category") as! NSDictionary
                print("CURRENT CAT")
                print(self.currentCat)
                completionHandler(responseData)
                self.usersVoted = responseData.value(forKey: "users") as! Array<NSDictionary>
            }
         }
     }
    
    func vote(points: Int) {
        print("VOTED")
        self.socket?.emit("userVoted", ["roomID": self.roomID, "userID": self.userID, "points": points]);
     }
    
    func voteResponse(completionHandler: @escaping (_ status: NSDictionary) -> Void) {
         socket?.on("userHasVotedEveryoneIsHappyLetsGo") { data,ack in
            if let responseData = data[0] as? NSDictionary {
                print("VOTE: ")
                print(responseData)
                self.usersVoted = responseData.value(forKey: "users") as! Array<NSDictionary>
                print("BITTE GIB USERS BRATAN")
                print(self.usersVoted)
                completionHandler(responseData)
            }
         }
     }
    
    func finishJoke() {
        print("JOKED")
        self.socket?.emit("userFinished", ["roomID": self.roomID, "userID": self.userID]);
     }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
