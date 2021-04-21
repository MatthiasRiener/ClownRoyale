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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView
        CategoryTable.dataSource = self
        CategoryTable.delegate = self
        CategoryTable.separatorStyle = .singleLine
        CategoryTable.separatorColor = .lightGray
        CategoryTable.separatorInset = .zero
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
