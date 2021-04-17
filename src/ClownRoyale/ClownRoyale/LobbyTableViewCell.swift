
import UIKit

//Custom UserTableViewCell
class LobbyTableViewCell: UITableViewCell {
    

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        status.layer.masksToBounds = true
        status.layer.cornerRadius = status.bounds.height / 2
        
        profileImage.image = UIImage(named: "clown")
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
