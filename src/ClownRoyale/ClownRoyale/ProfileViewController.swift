import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var burger1: UIButton!
    @IBOutlet weak var burger2: UIButton!
    @IBOutlet weak var burger3: UIButton!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var firstRing: UIView!
    @IBOutlet weak var secondRing: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
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
        
        box.layer.shadowOpacity = 0.3
        box.layer.shadowOffset = CGSize(width: 0, height: 7)
        box.layer.shadowRadius = 5.0
        box.layer.shadowColor = UIColor.black.cgColor
        box.layer.zPosition = 1.0
        
        firstRing.layer.opacity = 0.15
        firstRing.layer.cornerRadius = 150.0
        secondRing.layer.opacity = 0.23
        //secondRing.layer.cornerRadius = 150.0
        //imageView.layer.cornerRadius = 150.0
        imageView.layer.zPosition = 1.0
    }
}
