import UIKit

//Custom UserTableViewCell
class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var ppv: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ppv.layer.masksToBounds = true
        ppv.layer.cornerRadius = ppv.bounds.height / 2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
