//
//  WatcherPerspectiveViewController.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 20.04.21.
//

import UIKit

class WatcherPerspectiveViewController: ViewController {
    
    @IBOutlet weak var categoryStack: UIStackView!
    
    @IBOutlet weak var jokeTellerView: UIImageView!
    
    
    @IBOutlet weak var btnTimer: UILabel!
    
    
    @IBOutlet weak var btn_one_burger: UIButton!
    
    @IBOutlet weak var btn_two_burger: UIButton!
    
    @IBOutlet weak var btn_three_burger: UIButton!
    
    
    
    @IBOutlet weak var btn_liked: UIButton!
    
    @IBOutlet weak var btn_neutral: UIButton!
    
    @IBOutlet weak var btn_disliked: UIButton!
    
    @IBOutlet weak var btn_hated: UIButton!
    
    
    override func viewDidLoad() {
        print("View wurde geladen...")
        self.jokeTellerView.image = UIImage(named: "VideoChat")
        self.jokeTellerView.layer.cornerRadius = 15
        
        
        self.btnTimer.layer.masksToBounds = true
        self.btnTimer.layer.cornerRadius = 15
        
        
        self.btn_one_burger.layer.cornerRadius = 5
        
        self.btn_two_burger.layer.cornerRadius = 5
        self.btn_three_burger.layer.cornerRadius = 5
        
        self.categoryStack.layer.zPosition = 3
        
        self.categoryStack.layer.cornerRadius = 15
        
        categoryStack.layer.shadowColor = UIColor(named: "DarkClownOrange")?.cgColor
        categoryStack.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        categoryStack.layer.shadowOpacity = 1.0
        categoryStack.layer.shadowRadius = 0.0
        
        self.btn_liked.layer.cornerRadius = 15
        
        self.btn_neutral.layer.cornerRadius = 15
        
        self.btn_disliked.layer.cornerRadius = 15
        
        self.btn_hated.layer.cornerRadius = 15
        
        
        btn_liked.layer.shadowColor = UIColor(named: "DarkClownGreen")?.cgColor
        btn_liked.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        btn_liked.layer.shadowOpacity = 1.0
        btn_liked.layer.shadowRadius = 0.0
        
        
        btn_neutral.layer.shadowColor = UIColor(named: "DarkClownYellow")?.cgColor
        btn_neutral.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        btn_neutral.layer.shadowOpacity = 1.0
        btn_neutral.layer.shadowRadius = 0.0
        
        
        btn_disliked.layer.shadowColor = UIColor(named: "DarkClownOrange")?.cgColor
        btn_disliked.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        btn_disliked.layer.shadowOpacity = 1.0
        btn_disliked.layer.shadowRadius = 0.0
        
        btn_hated.layer.shadowColor = UIColor(named: "ClownRedDunkel")?.cgColor
        btn_hated.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        btn_hated.layer.shadowOpacity = 1.0
        btn_hated.layer.shadowRadius = 0.0
    }
    
}
