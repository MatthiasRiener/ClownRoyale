import UIKit

class LoginController: ViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LOGIN-BUTTON
        loginbtn.layer.cornerRadius = 10
        loginbtn.layer.shadowColor = UIColor(named: "ClownRedDunkel")?.cgColor
        loginbtn.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        loginbtn.layer.shadowOpacity = 1.0
        loginbtn.layer.shadowRadius = 0.0
        loginbtn.layer.masksToBounds = false
        loginbtn.layer.cornerRadius = 10
        
        //REGISTEr-BUTTON
        registerbtn.layer.cornerRadius = 10
        registerbtn.layer.shadowColor = UIColor(named: "ClownRedDunkel")?.cgColor
        registerbtn.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        registerbtn.layer.shadowOpacity = 1.0
        registerbtn.layer.shadowRadius = 0.0
        registerbtn.layer.masksToBounds = false
        registerbtn.layer.cornerRadius = 10
        registerbtn.titleLabel?.textAlignment = NSTextAlignment.center
        
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 5
        container.layer.borderColor = UIColor(named: "ClownRedHell")?.cgColor
        
        titel.layer.cornerRadius = titel.layer.bounds.height / 2
        titel.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        defaults.removeObject(forKey: "a_token")
        
        sendRequestToServer(url: "/auth/login", method: "POST", body: ["username": self.username.text!, "password": self.password.text!], login: true)?
            .then {data in
                setAToken(token: "\(data["access"]!)")
                setRToken(token: "\(data["refresh"]!)")
                self.performSegue(withIdentifier: "login", sender: nil)
            }
    }
    
    @IBAction func onSendRequest(_ sender: Any) {
        sendRequestToServer(url: "/shop/todaysItem", method: "GET")?
            .then { data in
                print("SHOP: \(data)")
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarViewController = segue.destination as! TabBarViewController
        tabBarViewController.modalPresentationStyle = .fullScreen
    }
}
