import UIKit

class ProfileView: ViewController {
    
    @IBOutlet weak var top: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstRing: UIView!
    @IBOutlet weak var secondRing: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameBox: UIView!
    @IBOutlet weak var pointsBox: UIView!
    @IBOutlet weak var achievments: UIView!
    @IBOutlet weak var statistic: UIView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var burger1: UIButton!
    @IBOutlet weak var burger2: UIButton!
    @IBOutlet weak var burger3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = top.bounds
        gradientLayer.colors = [UIColor(named: "ClownBlue")?.cgColor as Any, UIColor(named: "ClownLightBlue")?.cgColor as Any]
        gradientLayer.shouldRasterize = true
        top.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        top.layer.shadowOpacity = 0.3
        top.layer.shadowOffset = CGSize(width: 0, height: 7)
        top.layer.shadowRadius = 5.0
        top.layer.shadowColor = UIColor.black.cgColor
        top.layer.zPosition = 1.0
        
        label.layer.zPosition = 1.0
        
        firstRing.layer.cornerRadius = 140.0
        secondRing.layer.cornerRadius = 120.0
        imageView.layer.cornerRadius = 90.0
        nameBox.layer.cornerRadius = 30.0
        pointsBox.layer.cornerRadius = 15.0
        
        achievments.layer.cornerRadius = 15.0
        achievments.layer.shadowOpacity = 0.5
        achievments.layer.shadowOffset = CGSize(width: 1, height: 1)
        achievments.layer.shadowRadius = 5.0
        achievments.layer.shadowColor = UIColor.darkGray.cgColor
        
        statistic.layer.cornerRadius = 15.0
        statistic.layer.shadowOpacity = 0.5
        statistic.layer.shadowOffset = CGSize(width: 1, height: 1)
        statistic.layer.shadowRadius = 5.0
        statistic.layer.shadowColor = UIColor.darkGray.cgColor
        
        stack.layer.zPosition = 1.0
        burger1.layer.zPosition = 1.0
        burger2.layer.zPosition = 1.0
        burger3.layer.zPosition = 1.0
        burger1.layer.cornerRadius = 5.0
        burger2.layer.cornerRadius = 5.0
        burger3.layer.cornerRadius = 5.0
    }
}
