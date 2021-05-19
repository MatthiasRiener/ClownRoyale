import Foundation
import SocketIO

let manager = SocketManager(socketURL: URL(string: "ws://localhost:5000")!, config: [.log(false), .compress])
let socket = manager.defaultSocket

func setupSocketEvents() {
    socket.on(clientEvent: .connect) {data, ack in
        print("socket connected")
        
        sendRequestToServer(url: "/user/getUID", method: "GET")?
        .then { data in
            print("ID: \(data["u_id"]!)")
            websocketsJoinLobby(id: "\(data["u_id"]!)")
        }
    }
    
    socket.on("joinLobbyRequest") {data, ack in
        print(data)
    }
    
    socket.connect()
}

func joinLobby() {
    print("JOINING LOBBY")
    setupSocketEvents()
}

func websocketsJoinLobby(id: String) {
    socket.emit("joinLobbyRequest", ["u_id": id])
}
