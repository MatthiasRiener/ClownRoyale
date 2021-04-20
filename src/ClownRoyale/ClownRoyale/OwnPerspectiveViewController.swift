//
//  OwnPerspectiveViewController.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 20.04.21.
//

import UIKit

class OwnPerspectiveViewController: ViewController {
    
    @IBOutlet weak var imgOwnView: UIImageView!
    
    @IBOutlet weak var stackCategory: UIStackView!
    
    
    @IBOutlet weak var viewersTableView: UITableView!
    
    override func viewDidLoad() {
        print("VIREW dIeD Load")
        self.viewersTableView.dataSource = self
        self.viewersTableView.separatorStyle = .singleLine
        self.viewersTableView.separatorColor = .lightGray
        self.viewersTableView.separatorInset = .zero
        self.stackCategory.layer.cornerRadius = 15
        
        self.imgOwnView.image = UIImage(named: "VideoChat")
        
        self.imgOwnView.layer.cornerRadius = 15
    }
}

extension OwnPerspectiveViewController: UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewer", for: indexPath) as! VotingTableViewCell
        
        cell.username.text = "funny franz"

        return cell
    }

    

}
