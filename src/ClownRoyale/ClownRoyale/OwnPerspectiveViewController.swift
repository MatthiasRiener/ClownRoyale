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
    
    
    
    @IBOutlet weak var btn_one_burger: UIButton!
    @IBOutlet weak var btn_two_burger: UIButton!
    @IBOutlet weak var btn_three_burger: UIButton!
    
    @IBOutlet weak var btnTimer: UILabel!
    
    override func viewDidLoad() {
        print("VIREW dIeD Load")
        self.viewersTableView.dataSource = self
        self.viewersTableView.separatorStyle = .singleLine
        self.viewersTableView.separatorColor = .lightGray
        self.viewersTableView.separatorInset = .zero
        self.stackCategory.layer.cornerRadius = 15
        
        self.imgOwnView.image = UIImage(named: "VideoChat")
        
        self.imgOwnView.layer.cornerRadius = 15
        
        self.btnTimer.layer.cornerRadius = 15
        
        self.btnTimer.layer.masksToBounds = true
        
        self.btn_one_burger.layer.cornerRadius = 5
        self.btn_two_burger.layer.cornerRadius = 5
        self.btn_three_burger.layer.cornerRadius = 5

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
