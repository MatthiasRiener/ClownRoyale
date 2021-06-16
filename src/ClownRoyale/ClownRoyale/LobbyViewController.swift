import UIKit

import TwilioVideo

class LobbyViewController: UIViewController {
    //UITableView mit Lobbyteilnehmer
    @IBOutlet weak var lobbyTable: UITableView!
    @IBOutlet weak var readyUp: UIView!
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    override func viewWillLayoutSubviews() {
        //super.updateViewConstraints()
        //self.tableHeight?.constant = self.lobbyTable.contentSize.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketIOManager.sharedInstance.newUserHasJoined(completionHandler: {data in
            print("NEW USER JOINED")
            print(data)
        })
        
        SocketIOManager.sharedInstance.changeStatusOfPlayer(completionHandler: {data in
            print("CHANGED USER STATUS")
            print(data)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        //TableView
        lobbyTable.dataSource = self
        lobbyTable.delegate = self
        lobbyTable.separatorStyle = .singleLine
        lobbyTable.separatorColor = .lightGray
        lobbyTable.separatorInset = .zero
        
        let gradient = CAGradientLayer()
        gradient.frame = readyUp.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        readyUp.layer.insertSublayer(gradient, at: 0)
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        self.readyUp.addGestureRecognizer(gesture)
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("join game")
        
        SocketIOManager.sharedInstance.userReady()
        SocketIOManager.sharedInstance.lobbyReadyToStartResponse(completionHandler: {data in
            print("DATA: ")
            print(data)
            if let tellerData = data.value(forKey: "teller") as? NSDictionary {
                let u_id = tellerData.value(forKey: "u_id") as! String
                print("TELLER:")
                print(u_id)
                if u_id == SocketIOManager.sharedInstance.userID {
                    print("I BIMS")
                    //self.performSegue(withIdentifier: "joinTeller", sender: self)
                    if let topController = UIApplication.topViewController() {
                        print("TOP CONTROLLER")
                        print(topController)
                        topController.performSegue(withIdentifier: "joinTeller", sender: topController)
                    }
                } else {
                    //self.performSegue(withIdentifier: "load", sender: self)
                    if let topController = UIApplication.topViewController() {
                        print("TOP CONTROLLER")
                        print(topController)
                        topController.performSegue(withIdentifier: "load", sender: topController)
                    }
                    print("DU BIMS")
                }
                /*print("RESPONSE: ")
                 print(responseData)
                 self.roomID = responseData.value(forKey: "lobbyID") as! String
                 self.users = responseData.value(forKey: "users") as! Array<NSDictionary>
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                 print(self.users)*/
                //let status = responseData.value(forKey: "status") as! Int
            }
        })
        //performSegue(withIdentifier: "join", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "load" {
            let watcherPerspektiveView = segue.destination as! LoadingViewController
            watcherPerspektiveView.modalPresentationStyle = .fullScreen
        }
        
        if segue.identifier == "joinTeller" {
            let categoryView = segue.destination as! CategoryViewController
            categoryView.modalPresentationStyle = .fullScreen
        }
    }
    
    @objc func refresh() {
        self.lobbyTable.reloadData()
    }
    
}

extension LobbyViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SocketIOManager.sharedInstance.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! LobbyTableViewCell
        
        cell.username.text = SocketIOManager.sharedInstance.users[indexPath.row].value(forKey: "name") as! String
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: SocketIOManager.sharedInstance.users[indexPath.row].value(forKey: "image") as! String)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.profileImage.image = image
                        cell.profileImage.contentMode = .scaleToFill
                    }
                }
            }
        }
        
        if SocketIOManager.sharedInstance.users[indexPath.row].value(forKey: "isReady") as! Bool {
            cell.status.text = "Ready"
        } else {
            cell.status.text = "Pending"
        }
        
        return cell
    }
}

extension LobbyViewController: UITableViewDelegate {
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
