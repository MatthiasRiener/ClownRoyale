//
//  OwnPerspectiveViewController.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 20.04.21.
//

import UIKit

import TwilioVideo

class OwnPerspectiveViewController: ViewController {
    
    
    @IBOutlet weak var imgOwnView: VideoView!
    
    @IBOutlet weak var stackCategory: UIStackView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var viewersTableView: UITableView!
    
    
    
    @IBOutlet weak var btn_one_burger: UIButton!
    @IBOutlet weak var btn_two_burger: UIButton!
    @IBOutlet weak var btn_three_burger: UIButton!
    
    @IBOutlet weak var btnTimer: UILabel!
    
    @IBOutlet weak var finishedButton: UIView!
    
    
    override func viewDidLoad() {
        
        if(WatcherPerspectiveViewController.videoSharedInstance.videoChat == nil){
            WatcherPerspectiveViewController.videoSharedInstance.setupCurrentClown()
        }
        WatcherPerspectiveViewController.videoSharedInstance.videoChat?.toggleMic(status: "unmute")
        print("VIREW dIeD Load")
        self.viewersTableView.dataSource = self
        self.viewersTableView.separatorStyle = .singleLine
        self.viewersTableView.separatorColor = .lightGray
        self.viewersTableView.separatorInset = .zero
        self.stackCategory.layer.cornerRadius = 15
        
        //self.imgOwnView.image = UIImage(named: "VideoChat")
        
        self.imgOwnView.layer.cornerRadius = 15
        
        self.btnTimer.layer.cornerRadius = 15
        
        self.btnTimer.layer.masksToBounds = true
        
        self.btn_one_burger.layer.cornerRadius = 5
        self.btn_two_burger.layer.cornerRadius = 5
        self.btn_three_burger.layer.cornerRadius = 5
        
        let gradient = CAGradientLayer()

        gradient.frame = finishedButton.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        finishedButton.layer.insertSublayer(gradient, at: 0)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        
        self.finishedButton.addGestureRecognizer(gesture)
        
        setupLocalView()
        
        self.categoryLabel.text = "\(SocketIOManager.sharedInstance.currentCat.value(forKey: "name")!)"
    }
    
    func setupLocalView(){
        
        if((WatcherPerspectiveViewController.videoSharedInstance.videoChat?.localVideoTrack) != nil){
            WatcherPerspectiveViewController.videoSharedInstance.videoChat?.localVideoTrack!.addRenderer(self.imgOwnView)
            WatcherPerspectiveViewController.videoSharedInstance.videoChat?.logMessage(messageText: "Video track created")
        }

    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("joke finished")
        performSegue(withIdentifier: "joke_finished", sender: self)
        WatcherPerspectiveViewController.videoSharedInstance.videoChat?.disconnect()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rankingView = segue.destination as! RankingViewController
        //Damit User nicht mehr zurückkommt
        rankingView.modalPresentationStyle = .fullScreen
        
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
