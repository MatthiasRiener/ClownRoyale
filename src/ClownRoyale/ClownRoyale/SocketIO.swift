import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
     var manager : SocketManager?
     var socket : SocketIOClient?
     var users = [String]()

     override init() {
         super.init()
     }

     /**
      Create socket connection.
      - parameter completionHandler : Called when complition will occure.
      - parameter connected : True when socket connected.
      - returns: nil
      */
     func createSocketConnection (completionHandler: @escaping (_ connected: Bool) -> Void) {
         manager = SocketManager(socketURL: URL(string: "ws://localhost:5000")!
            ,config: [.log(false)])

         socket = manager?.defaultSocket

         socket?.on(clientEvent: .connect) { data, ack in
             print("socket connected.")
             completionHandler(true)
         }
         socket?.connect()
     }

     /**
      Disconnect socket.
      */
     func closeConnection() {
         socket?.disconnect()
     }

     /**
      Add new user to socket.
      - parameter username: current user name.
      - parameter userid: current user id.
      - parameter image: current user profile image url.
      - returns: nil
      */
     func joinLobby() {
        sendRequestToServer(url: "/user/getUID", method: "GET")?
        .then { data in
            print("Id: \(data["u_id"]!)")
            self.socket?.emit("joinLobbyRequest", ["u_id": "\(data["u_id"]!)"]) //adduser
        }
     }

     /**
      Add handler for total connected user.
      - parameter completionHandler : Called when complition will occure.
      - parameter userCount : Total number of  connected users.
      - returns: nil
      */
    func joinLobbyResponse(completionHandler: @escaping (_ status: Int) -> Void) {
         socket?.on("joinLobbyResponse") { data,ack in //updateconnecteduser
            print("JOINLOBBYRESPONSE")
            //completionHandler("\(String(describing: snippet.value(forKey: "viewers")!))")
            if let responseData = data[0] as? NSDictionary {
                print("RESPONSE: ")
                print(responseData)
                let status = responseData.value(forKey: "status") as! Int
                //self.users.removeAll()
                self.users = responseData.value(forKey: "users") as! Array<String>
                print(self.users)
                completionHandler(status)
            }
         }
     }

     /**
      Send new message.
      - parameter message: user text message.
      - returns: nil
      */
     /*func sendMessage(message :String){
         if socket?.status == .connected {
             self.socket?.emit("sendchat", ["message": message]) //sendchat
         }
         else{
             print("socket not connected")
         }
     }*/
}
