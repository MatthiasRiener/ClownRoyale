import UIKit

class PodiumViewController: UIViewController {

    @IBOutlet weak var podiumTable: UITableView!
    var users = [NSDictionary]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        podiumTable.reloadData()
        
        //View Einstellungen
        podiumTable.dataSource = self
        podiumTable.delegate = self
        podiumTable.separatorStyle = .singleLine
        podiumTable.separatorColor = .lightGray
        podiumTable.separatorInset = .zero

        
        print("Loading alltime podium...")
        
        self.fetchUserRanking()
        // Do any additional setup after loading the view.
    }
    
    
    func fetchUserRanking() {
        sendRequestToServer(url: "/user/rankedUsers", method: "GET")?
            .then {data in
                print("SOOOSSSSSOOSOSOSOSOSOS")
                print(data)
                
                if let responseData = data as? NSDictionary {
                    self.users = responseData.value(forKey: "res") as! Array<NSDictionary>
                    self.podiumTable.reloadData()
                }
                
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PodiumViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return SocketIOManager.sharedInstance.usersLeaderboard.count
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_podium", for: indexPath) as! PodiumTableViewCell
        
        cell.username.text = self.users[indexPath.row].value(forKey: "name") as! String
        cell.points.text = "\(self.users[indexPath.row].value(forKey: "points") as! Int)"
        
        cell.placement.text = "\(indexPath.item+1)."
        

        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: self!.users[indexPath.row].value(forKey: "image") as! String)!) {
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

extension PodiumViewController: UITableViewDelegate {
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

