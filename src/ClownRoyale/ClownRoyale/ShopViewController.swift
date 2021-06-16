import UIKit

class ShopViewController: ViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewBackground: UIView!
    
    @IBOutlet weak var shopCoins: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var moneyButton: UIButton!
    
    @IBOutlet weak var secondShopItem: UIView!
    @IBOutlet weak var firstShopItem: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View Einstellungen
        shopCoins.backgroundColor = UIColor(named: "ClownYellow")
        shopCoins.layer.cornerRadius = shopCoins.layer.bounds.height / 2
        shopCoins.clipsToBounds = true
        shopCoins.layer.borderWidth = 5
        shopCoins.layer.borderColor = UIColor.white.cgColor
        
        topView.layer.shadowOpacity = 0.3
        topView.layer.shadowOffset = CGSize(width: 0, height: 7)
        topView.layer.shadowRadius = 5.0
        topView.layer.shadowColor = UIColor.darkGray.cgColor
        
        imageView.layer.cornerRadius = imageView.layer.bounds.height / 2
        imageView.layer.zPosition = 1.0
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageView.layer.shadowRadius = 5.0
        imageView.layer.shadowColor = UIColor.darkGray.cgColor
        
        imageViewBackground.layer.cornerRadius = 10.0
        imageViewBackground.layer.shadowOpacity = 0.5
        imageViewBackground.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageViewBackground.layer.shadowRadius = 5.0
        imageViewBackground.layer.shadowColor = UIColor.darkGray.cgColor
        
        iconButton.layer.cornerRadius = 5.0
        
        moneyButton.layer.cornerRadius = 5.0
        
        firstShopItem.layer.cornerRadius = 10.0
        firstShopItem.layer.shadowOpacity = 0.5
        firstShopItem.layer.shadowOffset = CGSize(width: 1, height: 1)
        firstShopItem.layer.shadowRadius = 5.0
        firstShopItem.layer.shadowColor = UIColor.darkGray.cgColor
        
        secondShopItem.layer.cornerRadius = 10.0
        secondShopItem.layer.shadowOpacity = 0.5
        secondShopItem.layer.shadowOffset = CGSize(width: 1, height: 1)
        secondShopItem.layer.shadowRadius = 5.0
        secondShopItem.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func onIconButton(_ sender: Any) {
        print("green button pressed :)")
    }
    
    
    @IBAction func onMoneyButton(_ sender: Any) {
        print("orange button pressed :)")
    }
}
