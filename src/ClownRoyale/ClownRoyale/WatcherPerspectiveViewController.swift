//
//  WatcherPerspectiveViewController.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 20.04.21.
//

import UIKit

class WatcherPerspectiveViewController: ViewController {
    
    
    @IBOutlet weak var jokeTellerView: UIImageView!
    
    @IBOutlet weak var btnJokeLiked: UIButton!
    
    @IBOutlet weak var btnJokeLessLiked: UIButton!
    
    
    
    override func viewDidLoad() {
        print("View wurde geladen...")
        self.jokeTellerView.image = UIImage(named: "VideoChat")
        self.jokeTellerView.layer.cornerRadius = 15
        
        self.btnJokeLiked.layer.cornerRadius = 15
        
        self.btnJokeLessLiked.layer.cornerRadius = 15
        
        
    }
    
}
