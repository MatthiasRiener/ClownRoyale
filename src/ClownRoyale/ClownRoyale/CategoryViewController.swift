//
//  CategoryViewController.swift
//  ClownRoyale
//
//  Created by Simon Koll on 21.04.21.
//


import UIKit

class CategoryViewController: UIViewController {

    //UITableView mit Category
    
    @IBOutlet weak var CategoryTable: UITableView!
    
    @IBOutlet weak var chooseCategory: UIView!
    
    var categories = [NSDictionary]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategories()
        
        if(VideoChat.videoSharedInstance.room == nil){
            VideoChat.videoSharedInstance.connect()
        }
        VideoChat.videoSharedInstance.toggleMic(status: "mute")

        //TableView
        CategoryTable.dataSource = self
        CategoryTable.delegate = self
        CategoryTable.separatorStyle = .singleLine
        CategoryTable.separatorColor = .lightGray
        CategoryTable.separatorInset = .zero
        
        let gradient = CAGradientLayer()

        gradient.frame = chooseCategory.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        chooseCategory.layer.insertSublayer(gradient, at: 0)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        
        self.chooseCategory.addGestureRecognizer(gesture)
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("category selected")
        performSegue(withIdentifier: "category_selected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let ownPerpektiveView = segue.destination as! OwnPerspectiveViewController
        //Damit User nicht mehr zurückkommt
        //ownPerpektiveView.modalPresentationStyle = .fullScreen
        
        if segue.identifier == "category_selected" {
            let ownPerspectiveView = segue.destination as! OwnPerspectiveViewController
            ownPerspectiveView.modalPresentationStyle = .fullScreen
        }
        
    }
    
    func getCategories() {
        print("GET CATEGORIES")
        sendRequestToServer(url: "/category/getCategories", method: "GET")?
        .then { data in
            if let responseData = data as? NSDictionary {
                self.categories = responseData.value(forKey: "cat") as! Array<NSDictionary>
            }
            
            self.CategoryTable.reloadData()
            print("CATEGORIES: ")
            print(self.categories)
            //print("Id: \(data["u_id"]!)")
            //self.userID = "\(data["u_id"]!)"
            //self.socket?.emit("joinLobbyRequest", ["u_id": "\(data["u_id"]!)"]) //adduser
        }
    }

}

extension CategoryViewController: UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "choosableCategory", for: indexPath) as! CategoryTableViewCell
        
        print(self.categories)
        cell.category.text = self.categories[indexPath.row].value(forKey: "name") as! String
        cell.ppv.text = "\(self.categories[indexPath.row].value(forKey: "points") as! Int)"

        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //self.viewWillLayoutSubviews()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hallo Koll!")
        print("\(self.categories[indexPath.row].value(forKey: "id")!)")
        SocketIOManager.sharedInstance.chooseCategory(cat: "\(self.categories[indexPath.row].value(forKey: "id")!)")
        SocketIOManager.sharedInstance.chooseCategoryRespone(completionHandler: {data in
            print("DATA 1:")
            print(data)
            SocketIOManager.sharedInstance.currentTeller = data
            self.performSegue(withIdentifier: "category_selected", sender: self)
        })
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
