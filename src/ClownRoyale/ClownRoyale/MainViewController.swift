//
//  MainViewController.swift
//  VideoChat
//
//  Created by Jan Donnerbauer on 01.04.21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var busImage: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet var pageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PLAY-BUTTON
        playButton.layer.shadowColor = UIColor(named: "ClownRedDunkel")?.cgColor
        playButton.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        playButton.layer.shadowOpacity = 1.0
        playButton.layer.shadowRadius = 0.0
        playButton.layer.masksToBounds = false
        playButton.layer.cornerRadius = 10
        
        
        //CREATE-GAME-BUTTON
        createButton.layer.shadowColor = UIColor(named: "ClownRedDunkel")?.cgColor
        createButton.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        createButton.layer.shadowOpacity = 1.0
        createButton.layer.shadowRadius = 0.0
        createButton.layer.masksToBounds = false
        createButton.layer.cornerRadius = 10
        createButton.titleLabel?.textAlignment = NSTextAlignment.center
        
        
        //Profile-Background
        let profileBackground = ProfileMainView()
        print(menuView.bounds.origin.x)
        print(menuView.bounds.width)
        profileBackground.frame = CGRect(x: 0, y: 0, width: menuView.bounds.width, height: menuView.bounds.height * 0.5)
        
        //important!!!! subview wird automatisch an parent angepasst, wenn autolayout engine fertig ist
        profileBackground.autoresizingMask = [.flexibleWidth]
        //profileBackground.backgroundColor = .blue
        
        
        //ClownImage
        let profileImage = UIImage(named: "clown")
        let profileImageView = UIImageView(frame:
                                        CGRect(
                                            x: profileBackground.frame.width/2 - (profileBackground.frame.height*0.8)/2,
                                            y: profileBackground.frame.height/2 - (profileBackground.frame.height*0.8)/2,
                                            width: profileBackground.frame.height * 0.8,
                                            height: profileBackground.frame.height * 0.8
                                        ))
        profileImageView.image = profileImage
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //profileImageView.backgroundColor = .red
        
        //Profilename
        let profileNameButton = UIButton(frame: CGRect(x: (menuView.bounds.width - 20)/2 - (menuView.bounds.width / 4), y: profileBackground.bounds.height - 25, width: menuView.bounds.width / 2, height: 50))
        profileNameButton.backgroundColor = UIColor(named: "ClownLightBlue")
        profileNameButton.setTitle("Gregory", for: .normal)
        profileNameButton.layer.cornerRadius = 20
        profileNameButton.clipsToBounds = true
        profileNameButton.layer.borderWidth = 5
        profileNameButton.layer.borderColor = UIColor.white.cgColor

        
        //In View einfügen
        menuView.addSubview(profileBackground)
        menuView.addSubview(profileImageView)
        menuView.addSubview(profileNameButton)
        //menuView.backgroundColor = .yellow
        
        /*
        let gradient = CAGradientLayer()

        gradient.frame = bottomText.bounds
        gradient.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        bottomText.layer.insertSublayer(gradient, at: 0)
        */
        /*
        let gradient2 = CAGradientLayer()

        gradient2.frame = pageView.bounds
        gradient2.colors = [UIColor(named: "ClownYellowHell")?.cgColor as Any, UIColor(named: "ClownYellow")?.cgColor as Any]
        gradient2.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient2.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        //gradient.frame = pageView.bounds

        pageView.layer.insertSublayer(gradient2, at: 0)
        */
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
