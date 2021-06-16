//
//  WatcherPerspectiveViewController.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 20.04.21.
//

import UIKit

import TwilioVideo

class WatcherPerspectiveViewController: ViewController {
    
    @IBOutlet weak var categoryStack: UIStackView!
    
    @IBOutlet weak var jokeTellerView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var btnTimer: UILabel!
    
    
    @IBOutlet weak var btn_one_burger: UIButton!
    
    @IBOutlet weak var btn_two_burger: UIButton!
    
    @IBOutlet weak var btn_three_burger: UIButton!
    
    
    
    @IBOutlet weak var btn_liked: UIButton!
    
    @IBOutlet weak var btn_neutral: UIButton!
    
    @IBOutlet weak var btn_disliked: UIButton!
    
    @IBOutlet weak var btn_hated: UIButton!
    
    @IBOutlet weak var voteButton: UIView!
    
    var counter = 0
    
    override func viewDidLoad() {
        
        SocketIOManager.sharedInstance.gameFinished(completionHandler: {data in
            print("GAME FINISHED EVENT WATCHER")
            self.performSegue(withIdentifier: "leaderboardWatcher", sender: self)
        })
        
        setupCurrentClown()
        VideoChat.videoSharedInstance.toggleMic(status: "mute")
        
        print("View wurde geladen...")
        //self.jokeTellerView.image = UIImage(named: "VideoChat")
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
        
        let gradient = CAGradientLayer()
        
        gradient.frame = voteButton.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        voteButton.layer.insertSublayer(gradient, at: 0)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        
        self.voteButton.addGestureRecognizer(gesture)
        
        self.categoryLabel.text = "\(SocketIOManager.sharedInstance.currentCat.value(forKey: "name")!)"
        
        print("CURRENT TELLER:")
        print(SocketIOManager.sharedInstance.currentTeller)
        
    }
    
    @IBAction func tenPoints(_ sender: Any) {
        print("+10")
        SocketIOManager.sharedInstance.vote(points: 10)
    }
    
    @IBAction func fivePoints(_ sender: Any) {
        print("+5")
        SocketIOManager.sharedInstance.vote(points: 5)
    }
    
    @IBAction func minusFivePoints(_ sender: Any) {
        print("-5")
        SocketIOManager.sharedInstance.vote(points: -5)
    }
    
    @IBAction func minusTenPoints(_ sender: Any) {
        print("-10")
        SocketIOManager.sharedInstance.vote(points: -10)
    }
    
    func setupCurrentClown(){
        
        if(VideoChat.videoSharedInstance.remoteView != nil){
            print("REMOTE: \(VideoChat.videoSharedInstance.remoteView)")
            VideoChat.videoSharedInstance.remoteView?.removeFromSuperview()
            VideoChat.videoSharedInstance.remoteView = nil
        }

        if(VideoChat.videoSharedInstance.remoteView == nil){
            print("REMOTE VIEW")
            
            VideoChat.videoSharedInstance.remoteView = VideoView(frame: CGRect.zero, delegate: self)

            self.jokeTellerView.insertSubview(VideoChat.videoSharedInstance.remoteView!, at: 0)
            
            // `VideoView` supports scaleToFill, scaleAspectFill and scaleAspectFit
            // scaleAspectFit is the default mode when you create `VideoView` programmatically.
            VideoChat.videoSharedInstance.remoteView!.contentMode = .scaleAspectFit;

            let centerX = NSLayoutConstraint(item: VideoChat.videoSharedInstance.remoteView!,
                                             attribute: NSLayoutConstraint.Attribute.centerX,
                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                             toItem: self.jokeTellerView,
                                             attribute: NSLayoutConstraint.Attribute.centerX,
                                             multiplier: 1,
                                             constant: 0);
            self.jokeTellerView.addConstraint(centerX)
            let centerY = NSLayoutConstraint(item: VideoChat.videoSharedInstance.remoteView!,
                                             attribute: NSLayoutConstraint.Attribute.centerY,
                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                             toItem: self.jokeTellerView,
                                             attribute: NSLayoutConstraint.Attribute.centerY,
                                             multiplier: 1,
                                             constant: 0);
            self.jokeTellerView.addConstraint(centerY)
            let width = NSLayoutConstraint(item: VideoChat.videoSharedInstance.remoteView!,
                                           attribute: NSLayoutConstraint.Attribute.width,
                                           relatedBy: NSLayoutConstraint.Relation.equal,
                                           toItem: self.jokeTellerView,
                                           attribute: NSLayoutConstraint.Attribute.width,
                                           multiplier: 1,
                                           constant: 0);
            self.jokeTellerView.addConstraint(width)
            let height = NSLayoutConstraint(item: VideoChat.videoSharedInstance.remoteView!,
                                            attribute: NSLayoutConstraint.Attribute.height,
                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                            toItem: self.jokeTellerView,
                                            attribute: NSLayoutConstraint.Attribute.height,
                                            multiplier: 1,
                                            constant: 0);
            self.jokeTellerView.addConstraint(height)
            
            /*
            VideoChat.videoSharedInstance.remoteView = jokeTellerView
            VideoChat.videoSharedInstance.remoteView?.reloadInputViews()
            VideoChat.videoSharedInstance.remoteView?.contentMode = .scaleAspectFit;
 */
            print(VideoChat.videoSharedInstance.remoteView)
            if(VideoChat.videoSharedInstance.room?.sid == nil){
                VideoChat.videoSharedInstance.connect()
            }
            
        }
        VideoChat.videoSharedInstance.changeClown()
    }

    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("voted")
        performSegue(withIdentifier: "voted", sender: self)
        //videoChat.disconnect()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "joinTeller" {
            let categoryView = segue.destination as! CategoryViewController
            categoryView.modalPresentationStyle = .fullScreen
        }
        
        if segue.identifier == "load" {
            let watcherPerspektiveView = segue.destination as! LoadingViewController
            watcherPerspektiveView.modalPresentationStyle = .fullScreen
        }
        
        if segue.identifier == "leaderboardWatcher" {
            let rankingView = segue.destination as! RankingViewController
            rankingView.modalPresentationStyle = .fullScreen
        }
        
    }
    
}
