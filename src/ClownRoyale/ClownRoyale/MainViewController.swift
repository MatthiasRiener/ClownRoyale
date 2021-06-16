import UIKit

class MainViewController: UIViewController {
    
    static let sharedInstance = MainViewController()
    
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
        
        //Profilename
        let profileNameButton = UIButton(frame: CGRect(x: (menuView.bounds.width)/2 - (menuView.bounds.width / 4), y: profileBackground.bounds.height - 25, width: menuView.bounds.width / 2, height: 50))
        profileNameButton.backgroundColor = UIColor(named: "ClownLightBlue")
        profileNameButton.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
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
    }
    
    @IBAction func onPlay(_ sender: Any) {
        SocketIOManager.sharedInstance.createSocketConnection(completionHandler: {connected in
            SocketIOManager.sharedInstance.joinLobby()
            SocketIOManager.sharedInstance.successJoin(completionHandler: {status in
                /*print("SCHREIB DES HI PLS ")
                 print(status)
                 if status == 1 {
                 self.performSegue(withIdentifier: "play", sender: self)
                 }*/
                print("SUCCES IN MAIN")
                print(status)
            })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lobbyViewController = segue.destination as! LobbyViewController
        //Damit User nicht mehr zurückkommt
        lobbyViewController.modalPresentationStyle = .fullScreen
    }
    
}
