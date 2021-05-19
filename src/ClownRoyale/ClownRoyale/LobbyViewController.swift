
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
        
        performSegue(withIdentifier: "join", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let watcherPerspektiveView = segue.destination as! WatcherPerspectiveViewController
        //Damit User nicht mehr zurückkommt
        watcherPerspektiveView.modalPresentationStyle = .fullScreen
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
