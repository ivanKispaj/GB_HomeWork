//
//  NewsPostCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 26.05.2022.
//

import UIKit

class NewsPostCell: UITableViewCell {

    
    @IBOutlet weak var newsPostUserAvatar: UIImageView!
    
    
    @IBOutlet weak var newsPostTextLabel: UILabel!
    
    @IBOutlet weak var newsPostSeenCount: UILabel!
    @IBOutlet weak var newsPostLikeCount: UILabel!
    @IBOutlet weak var newsPostLikeHeart: UIImageView!
    @IBOutlet weak var newsPostUserSeen: UILabel!
    @IBOutlet weak var newsPostUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
