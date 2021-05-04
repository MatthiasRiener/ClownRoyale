import UIKit

class RegisterController: ViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onRegister(_ sender: Any) {
        //sendRequestToServer(url: "/fakeLogin", method: "GET")
        //sendRequestToServer(url: "/loginRoute", method: "POST", data: ["name": "Lukas"])
        sendRequestToServer(url: "/register", method: "POST", data: ["username": self.username.text!, "email": self.email.text!, "password": self.password.text!])
        print("\(self.username.text!) - \(self.email.text!) - \(self.password.text!)")
    }
    
}
