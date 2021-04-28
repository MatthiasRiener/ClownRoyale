import UIKit

class LoginController: ViewController {
    
    @IBAction func username(_ sender: Any) {
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        print("\(self.username.text!) - \(self.password.text!)")
    }
    
}
