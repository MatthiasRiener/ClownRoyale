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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let ownPerpektiveView = segue.destination as! OwnPerspectiveViewController
        //Damit User nicht mehr zurückkommt
        ownPerpektiveView.modalPresentationStyle = .fullScreen
        
    }

}

extension CategoryViewController: UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "choosableCategory", for: indexPath) as! CategoryTableViewCell
        
        cell.category.text = "Dark Humor"

        return cell
    }

    

}

extension CategoryViewController: UITableViewDelegate {
    
    //Möglichkeit height neu auszurechnen, scrollen geht dann nicht mehr
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //self.viewWillLayoutSubviews()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
