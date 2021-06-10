//
//  WatcherPerspectiveViewController.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 20.04.21.
//

import UIKit

import TwilioVideo

class WatcherPerspectiveViewController: ViewController {
    
    static let videoSharedInstance = WatcherPerspectiveViewController()
    
    var currentTeller: NSDictionary = [:]
    
    @IBOutlet weak var categoryStack: UIStackView!
    
    @IBOutlet weak var categoryLabel: UILabel!
        
    @IBOutlet weak var jokeTellerView: VideoView!
    
    @IBOutlet weak var btnTimer: UILabel!
    
    
    @IBOutlet weak var btn_one_burger: UIButton!
    
    @IBOutlet weak var btn_two_burger: UIButton!
    
    @IBOutlet weak var btn_three_burger: UIButton!
    
    
    
    @IBOutlet weak var btn_liked: UIButton!
    
    @IBOutlet weak var btn_neutral: UIButton!
    
    @IBOutlet weak var btn_disliked: UIButton!
    
    @IBOutlet weak var btn_hated: UIButton!
    
    @IBOutlet weak var voteButton: UIView!
    
    var videoChat : VideoChat?
    var counter = 0
    
    override func viewDidLoad() {
        
        setupCurrentClown()
        videoChat?.toggleMic(status: "mute")

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
        print(self.currentTeller)
        
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
        if(videoChat == nil){
            videoChat = VideoChat()
        }
        
        if(videoChat?.remoteView == nil){
            videoChat?.remoteView = jokeTellerView
            videoChat?.remoteView?.reloadInputViews()
            videoChat?.remoteView?.contentMode = .scaleAspectFit;
            
            videoChat?.connect()
        }
        self.changeClown()
    }
    
    func changeClown(){
        print("PLS GO")
        print(videoChat?.room?.remoteParticipants)
        if(videoChat?.room?.remoteParticipants.count ?? 0 > 0){
                    print("IFFFFFFF")
            let videoPublications = videoChat?.remoteParticipant?.remoteVideoTracks
            
            
            if(videoPublications != nil){
            for publication in videoPublications! {
                    if let subscribedVideoTrack = publication.remoteTrack,
                        publication.isTrackSubscribed {
                        print("gg")
                        subscribedVideoTrack.removeRenderer(videoChat?.remoteView! as! VideoRenderer)
                        
                    }
            }

            //videoChat?.remoteView?.invalidateRenderer()
                var teller = self.currentTeller.value(forKey: "teller") as! NSDictionary
                var userID = teller.value(forKey: "u_id") as! String
                print("USERID")
                print(userID)
            
                /*
                 var remainingParticipants = videoChat?.room?.remoteParticipants
                 
                 for participant in videoChat?.room?.remoteParticipants as! [RemoteParticipant] {
                     // Find the first renderable track.
                     print("\(participant.identity) IDENTITY")
                     print("\(userID) IDENTITY")
                     if participant.identity == userID {
                         videoChat?.remoteParticipant? = participant
                         videoChat?.renderRemoteParticipant(participant: (videoChat?.remoteParticipant)!)
                     }
                 }
                 */
            print(videoChat?.room?.remoteParticipants.count ?? 0)
            if(counter >= (videoChat?.room?.remoteParticipants.count)! - 1){
                counter = 0
            }else {
                counter = counter+1
            }
            //videoChat?.remoteParticipant = nil

            videoChat?.remoteParticipant? = (videoChat?.room?.remoteParticipants[counter])!
            
            print(videoChat?.remoteParticipant?.identity ?? "oje")
            print(videoChat?.room?.remoteParticipants.count ?? 0)
            print(counter)
            
            videoChat?.renderRemoteParticipant(participant: (videoChat?.remoteParticipant)!)
        }
    }
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("voted")
        performSegue(withIdentifier: "voted", sender: self)
        //videoChat.disconnect()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let categoryView = segue.destination as! CategoryViewController
        //Damit User nicht mehr zurückkommt
        categoryView.modalPresentationStyle = .fullScreen
        
    }
    
}
