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
