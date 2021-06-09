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
                completionHandler(status)
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
            }
         }
     }
}
