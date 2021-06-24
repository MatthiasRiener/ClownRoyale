import UIKit

class ProfileView: ViewController {
    
    
    @IBOutlet weak var podium: UIImageView!
    @IBOutlet weak var profileContainer: UIView!
    @IBOutlet weak var achievments: UIView!
    @IBOutlet weak var statistic: UIView!
    
    var profileImageView: UIImageView!;
    var profileNameButton: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadUserInformation()

        
        //Berechnungs-Dummy
        var dummy = profileContainer.layer.bounds.height / 3
        
        
        print("HEIGHT: \(self.view.bounds.height)")
        
        //Höhe richtet sich nach Gerätehöhe
        if(self.view.bounds.height > 700){
            dummy = profileContainer.layer.bounds.height / 2
        }
        
        //Profile-Background
        let profileBackground = ProfileMainView()
        print(profileContainer.bounds.origin.x)
        print(profileContainer.bounds.width)
        profileBackground.frame = CGRect(x: 0, y: dummy - (profileContainer.bounds.height * 0.5 / 2), width: profileContainer.bounds.width, height: profileContainer.bounds.height * 0.5)
        //important!!!! subview wird automatisch an parent angepasst, wenn autolayout engine fertig ist
        profileBackground.autoresizingMask = [.flexibleWidth]
        
        //ClownImage
        let profileImage = UIImage(named: "clown")
        profileImageView = UIImageView(frame:
                                            CGRect(
                                                x: profileBackground.frame.width/2 - (profileBackground.frame.height*0.7)/2,
                                                y:
                                                    dummy - (profileBackground.frame.height*0.7)/2,
                                                width: profileBackground.frame.height * 0.7,
                                                height: profileBackground.frame.height * 0.7
                                            ))
        profileImageView.image = profileImage
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        
        //Profilename
        profileNameButton = UIButton(frame: CGRect(x: (profileContainer.bounds.width)/2 - (profileContainer.bounds.width / 3) / 2, y: dummy + profileBackground.bounds.height / 2 - 25, width: profileContainer.bounds.width / 3, height: 50))
        profileNameButton.backgroundColor = UIColor(named: "ClownLightBlue")
        profileNameButton.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        profileNameButton.setTitle("Gregory", for: .normal)
        profileNameButton.layer.cornerRadius = 20
        profileNameButton.clipsToBounds = true
        profileNameButton.layer.borderWidth = 5
        profileNameButton.layer.borderColor = UIColor.white.cgColor
        
        //Profilename
        let profilePoints = UIButton(frame: CGRect(x: (profileContainer.bounds.width)/2 - (profileContainer.bounds.width / 4) / 2, y: dummy + 50 + profileBackground.bounds.height / 2 - 20, width: profileContainer.bounds.width / 4, height: 40))
        profilePoints.backgroundColor = UIColor(named: "ClownYellow")
        profilePoints.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        profilePoints.setTitle("18420", for: .normal)
        profilePoints.layer.cornerRadius =  profilePoints.layer.bounds.height / 2
        profilePoints.clipsToBounds = true
        profilePoints.layer.borderWidth = 5
        profilePoints.layer.borderColor = UIColor.white.cgColor
        
        
        //In View einfügen
        profileContainer.addSubview(profileBackground)
        profileContainer.addSubview(profileImageView)
        profileContainer.addSubview(profileNameButton)
        profileContainer.addSubview(profilePoints)
        
        achievments.layer.cornerRadius = 15.0
        achievments.layer.shadowOpacity = 0.5
        achievments.layer.shadowOffset = CGSize(width: 1, height: 1)
        achievments.layer.shadowRadius = 5.0
        achievments.layer.shadowColor = UIColor.darkGray.cgColor
        
        statistic.layer.cornerRadius = 15.0
        statistic.layer.shadowOpacity = 0.5
        statistic.layer.shadowOffset = CGSize(width: 1, height: 1)
        statistic.layer.shadowRadius = 5.0
        statistic.layer.shadowColor = UIColor.darkGray.cgColor
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        podium.isUserInteractionEnabled = true
        podium.addGestureRecognizer(gesture)
        
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        print("CLICKED")
        performSegue(withIdentifier: "podium", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "podium" {
            /*
            let podiumViewController = segue.destination as! PodiumViewController
            podiumViewController.modalPresentationStyle = .fullScreen
 */
        }
    }
    
    
    func loadUserInformation() {
        print("Hallo. Ich beantrage die User Informationen.")
        
        sendRequestToServer(url: "/user/getProfileInformation", method: "GET")?
            .then {data in
                if let responseData = data["user"] as? NSDictionary {
                    print(responseData)
                    var image = responseData.value(forKey: "image") as! String
                    var username = responseData.value(forKey: "name") as! String
                    print(image)
                    self.profileNameButton.setTitle(username, for: .normal)
                    
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: URL(string: image)!) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.profileImageView.image = image
                                    self?.profileImageView.contentMode = .scaleToFill
                                }
                            }
                        }
                    }


                }
            }
    }
}
