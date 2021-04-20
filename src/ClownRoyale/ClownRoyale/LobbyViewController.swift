
import UIKit

class LobbyViewController: UIViewController {

    //UITableView mit Lobbyteilnehmer
    @IBOutlet weak var lobbyTable: UITableView!
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    override func viewWillLayoutSubviews() {
        //super.updateViewConstraints()
        //self.tableHeight?.constant = self.lobbyTable.contentSize.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView
        lobbyTable.dataSource = self
        lobbyTable.delegate = self
        lobbyTable.separatorStyle = .singleLine
        lobbyTable.separatorColor = .lightGray
        lobbyTable.separatorInset = .zero
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

extension LobbyViewController: UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! LobbyTableViewCell
        
        cell.username.text = "Henrike Gustavson"

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
