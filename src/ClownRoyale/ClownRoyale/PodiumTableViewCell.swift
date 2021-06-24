//
//  PodiumTableViewCell.swift
//  ClownRoyale
//
//  Created by Jan Donnerbauer on 23.06.21.
//

import UIKit

class PodiumTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var placement: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var points: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        points.layer.masksToBounds = true
        points.layer.cornerRadius = points.bounds.height / 2
        
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
