import UIKit

class RegisterController: ViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerbtn.layer.borderWidth = 2
        self.registerbtn.layer.cornerRadius = 10
        self.registerbtn.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func onRegister(_ sender: Any) {
        print("\(self.username.text!) - \(self.email.text!) - \(self.password.text!)")
    }
    
}
