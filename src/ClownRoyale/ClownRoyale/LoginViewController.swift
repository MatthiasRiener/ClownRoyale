import UIKit

class LoginController: ViewController {
    let defaults = UserDefaults.standard
    
    @IBAction func username(_ sender: Any) {
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        defaults.removeObject(forKey: "a_token")

        sendRequestToServer(url: "/auth/login", method: "POST", body: ["username": self.username.text!, "password": self.password.text!], login: true)
        .then {data in
            setAToken(token: "\(data["access"]!)")
            setRToken(token: "\(data["refresh"]!)")
        }
    }
    
    @IBAction func onSendRequest(_ sender: Any) {
        sendRequestToServer(url: "/shop/todaysItem", method: "GET")
        .then { data in
            print("SHOP: \(data["shop"])")
        }
    }
}
