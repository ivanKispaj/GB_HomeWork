//
//  ExtendTableUserCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 07.03.2022.
//

import UIKit

class ExtendTableUserCell: UITableViewCell {

    @IBOutlet weak var ExtendImageCell: UIImageView!
    @IBOutlet weak var ExtendLabelCity: UILabel!
    @IBOutlet weak var ExtendLabelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
