//
//  TableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.04.2022.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    @IBOutlet weak var linkUserLogo: UIImageView!
    @IBOutlet weak var linkUserName: UILabel!
    @IBOutlet weak var linkDate: UILabel!
    @IBOutlet weak var linkLink: UILabel!
    @IBOutlet weak var linkText: UILabel!
    @IBOutlet weak var linkCaption: UILabel!
    
    @IBOutlet weak var linkSeenCount: UILabel!
    @IBOutlet weak var linkLikeHeart: UIImageView!
    @IBOutlet weak var linkLikeCount: UILabel!
    @IBOutlet weak var linkViewLike: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.linkViewLike.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
