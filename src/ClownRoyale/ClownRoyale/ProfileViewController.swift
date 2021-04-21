import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var burger1: UIButton!
    @IBOutlet weak var burger2: UIButton!
    @IBOutlet weak var burger3: UIButton!
    @IBOutlet weak var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = topView.bounds
        gradientLayer.colors = [UIColor(named: "ClownBlue")?.cgColor as Any, UIColor(named: "ClownLightBlue")?.cgColor as Any]
        gradientLayer.shouldRasterize = true
        topView.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        let gradientLayerBottom = CAGradientLayer()
        gradientLayerBottom.frame = topBarView.bounds
        gradientLayerBottom.colors = [UIColor(named: "ClownBlue")?.cgColor as Any, UIColor(named: "ClownLightBlue")?.cgColor as Any]
        gradientLayerBottom.shouldRasterize = true
        topBarView.layer.addSublayer(gradientLayerBottom)
        gradientLayerBottom.startPoint = CGPoint(x: 0, y: 0)
        gradientLayerBottom.endPoint = CGPoint(x: 1, y: 0)
        
        label.layer.zPosition = 1.0
        stack.layer.zPosition = 1.0
        burger1.layer.zPosition = 1.0
        burger2.layer.zPosition = 1.0
        burger3.layer.zPosition = 1.0
        burger1.layer.cornerRadius = 5.0
        burger2.layer.cornerRadius = 5.0
        burger3.layer.cornerRadius = 5.0
    }
}
