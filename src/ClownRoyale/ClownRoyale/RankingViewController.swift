import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet weak var tableRanking: UITableView!
    @IBOutlet weak var bottomLeave: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableRanking.reloadData()
        
        //View Einstellungen
        tableRanking.dataSource = self
        tableRanking.delegate = self
        tableRanking.separatorStyle = .singleLine
        tableRanking.separatorColor = .lightGray
        tableRanking.separatorInset = .zero
        
        let gradient = CAGradientLayer()
        gradient.frame = bottomLeave.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        bottomLeave.layer.insertSublayer(gradient, at: 0)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        self.bottomLeave.addGestureRecognizer(gesture)
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("leave lobby")
        performSegue(withIdentifier: "leave", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainViewController = segue.destination as! TabBarViewController
        //Damit User nicht mehr zurückkommt
        mainViewController.modalPresentationStyle = .fullScreen
    }
}

extension RankingViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SocketIOManager.sharedInstance.usersLeaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_ranking", for: indexPath) as! RankingTableViewCell
        
        /*cell.username.text = "Hans_Peter"
         let points = 100 - (indexPath.item)*10
         cell.points.text = "\(points)"
         cell.placement.text = "\(indexPath.item+1)."*/
        
        cell.username.text = "\(SocketIOManager.sharedInstance.usersLeaderboard[indexPath.row].value(forKey: "name")!)"
        cell.points.text = "\(SocketIOManager.sharedInstance.usersLeaderboard[indexPath.row].value(forKey: "points")!)"
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: SocketIOManager.sharedInstance.usersLeaderboard[indexPath.row].value(forKey: "image") as! String)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.profileImage.image = image
                        cell.profileImage.contentMode = .scaleToFill
                    }
                }
            }
        }
        
        cell.placement.text = "\(indexPath.row+1)."
        
        return cell
    }
    
    
    
}

extension RankingViewController: UITableViewDelegate {
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
