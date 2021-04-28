import UIKit

class RegisterController: ViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onRegister(_ sender: Any) {
        print("\(self.username.text!) - \(self.email.text!) - \(self.password.text!)")
    }
    
}
