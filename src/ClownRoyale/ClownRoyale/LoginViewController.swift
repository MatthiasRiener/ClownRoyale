import UIKit

class LoginController: ViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var loginbtn: UIButton!
    
    
    @IBOutlet weak var registerbtn: UIButton!
    @IBAction func username(_ sender: Any) {
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginbtn.layer.borderWidth = 2
        self.loginbtn.layer.cornerRadius = 10
        self.loginbtn.layer.borderColor = UIColor.red.cgColor
        self.registerbtn.layer.borderWidth = 2
        self.registerbtn.layer.cornerRadius = 10
        self.registerbtn.layer.borderColor = UIColor.red.cgColor
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
        let mainViewController = segue.destination as! MainViewController
        mainViewController.modalPresentationStyle = .fullScreen
    }
}
