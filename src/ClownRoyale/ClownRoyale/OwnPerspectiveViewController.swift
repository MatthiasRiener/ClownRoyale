import UIKit

import TwilioVideo

class OwnPerspectiveViewController: ViewController {
    
    
    @IBOutlet weak var imgOwnView: VideoView!
    
    @IBOutlet weak var stackCategory: UIStackView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var viewersTableView: UITableView!
    
    @IBOutlet weak var btn_one_burger: UIButton!
    @IBOutlet weak var btn_two_burger: UIButton!
    @IBOutlet weak var btn_three_burger: UIButton!
    
    @IBOutlet weak var btnTimer: UILabel!
    
    @IBOutlet weak var finishedButton: UIView!
    
    
    override func viewDidLoad() {
        
        self.viewersTableView.reloadData()
        
        SocketIOManager.sharedInstance.voteResponse(completionHandler: {data in
            self.viewersTableView.reloadData()
        })
        
        SocketIOManager.sharedInstance.gameFinished(completionHandler: {data in
            print("GAME FINISHED EVENT OWN")
            self.performSegue(withIdentifier: "leaderboardOwn", sender: self)
        })
        
        //Falls noch nicht bereits in einem Raum --> connect
        if(VideoChat.videoSharedInstance.room == nil){
            VideoChat.videoSharedInstance.connect()
        }
        //User unmuted
        VideoChat.videoSharedInstance.toggleMic(status: "unmute")
        
        
        print("VIREW dIeD Load")
        self.viewersTableView.dataSource = self
        self.viewersTableView.separatorStyle = .singleLine
        self.viewersTableView.separatorColor = .lightGray
        self.viewersTableView.separatorInset = .zero
        self.stackCategory.layer.cornerRadius = 15
        
        //self.imgOwnView.image = UIImage(named: "VideoChat")
        
        self.imgOwnView.layer.cornerRadius = 15
        
        self.btnTimer.layer.cornerRadius = 15
        
        self.btnTimer.layer.masksToBounds = true
        
        self.btn_one_burger.layer.cornerRadius = 5
        self.btn_two_burger.layer.cornerRadius = 5
        self.btn_three_burger.layer.cornerRadius = 5
        
        let gradient = CAGradientLayer()

        gradient.frame = finishedButton.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        finishedButton.layer.insertSublayer(gradient, at: 0)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        
        self.finishedButton.addGestureRecognizer(gesture)
        
        setupLocalView()
        
        self.categoryLabel.text = "\(SocketIOManager.sharedInstance.currentCat.value(forKey: "name")!)"
    }
    
    /*
     Erstellt Ansicht für lokalen Videostream (unten rechts in der View)
     */
    func setupLocalView(){
        if((VideoChat.videoSharedInstance.localVideoTrack) != nil){
            VideoChat.videoSharedInstance.localVideoTrack!.addRenderer(self.imgOwnView)
            VideoChat.videoSharedInstance.logMessage(messageText: "Video track created")
        }
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("joke finished")
        performSegue(withIdentifier: "joke_finished", sender: self)
        SocketIOManager.sharedInstance.finishJoke()
        VideoChat.videoSharedInstance.disconnect()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "joinTeller" {
            let categoryView = segue.destination as! CategoryViewController
            categoryView.modalPresentationStyle = .fullScreen
        }
        
        if segue.identifier == "load" {
            let watcherPerspektiveView = segue.destination as! LoadingViewController
            watcherPerspektiveView.modalPresentationStyle = .fullScreen
        }
        
        if segue.identifier == "leaderboardOwn" {
            let rankingView = segue.destination as! RankingViewController
            rankingView.modalPresentationStyle = .fullScreen
        }
    }
}

extension OwnPerspectiveViewController: UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SocketIOManager.sharedInstance.usersVoted.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewer", for: indexPath) as! VotingTableViewCell
        
        //cell.username.text = "funny franz"
        cell.username.text = SocketIOManager.sharedInstance.usersVoted[indexPath.row].value(forKey: "name") as! String

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: SocketIOManager.sharedInstance.usersVoted[indexPath.row].value(forKey: "image") as! String)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.profileImage.image = image
                        cell.profileImage.contentMode = .scaleToFill
                    }
                }
            }
        }
        
        print("USERSSDADASDSD")
        print(SocketIOManager.sharedInstance.usersVoted)
        
        if SocketIOManager.sharedInstance.usersVoted[indexPath.row].value(forKey: "hasVoted") as! Bool {
            cell.status.text = "Voted"
        } else {
            cell.status.text = "Waiting"
        }

        return cell
    }

    

}
