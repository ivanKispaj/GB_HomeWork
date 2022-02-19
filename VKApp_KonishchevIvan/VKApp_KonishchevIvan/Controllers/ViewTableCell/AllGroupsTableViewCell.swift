//
//  AllGroupsTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 19.02.2022.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var allGroupLablel: UILabel!
    @IBOutlet weak var allGroupView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
