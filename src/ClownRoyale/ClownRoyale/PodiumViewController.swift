import UIKit

class PodiumViewController: UIViewController {

    @IBOutlet weak var podiumTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        podiumTable.reloadData()
        
        //View Einstellungen
        podiumTable.dataSource = self
        podiumTable.delegate = self
        podiumTable.separatorStyle = .singleLine
        podiumTable.separatorColor = .lightGray
        podiumTable.separatorInset = .zero

        // Do any additional setup after loading the view.
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_podium", for: indexPath) as! PodiumTableViewCell
        
        cell.username.text = "Hans_Peter"
        let points = 100 - (indexPath.item)*10
        cell.points.text = "\(points)"
        cell.placement.text = "\(indexPath.item+1)."
        /*
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
        */
        cell.placement.text = "\(indexPath.row+1)."
        
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

