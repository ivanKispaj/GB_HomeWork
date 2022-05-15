//
//  SinglePhotoAndTextTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class SinglePhotoAndTextTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var lableOnPhoto: UILabel!
    @IBOutlet weak var lableUserNameOnPhoto: UILabel!
    @IBOutlet weak var imageParentView: UIView!
    
    @IBOutlet weak var photoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeControll: ControlForLike!
    
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsUserAvatar: UIImageView!
    @IBOutlet weak var newsUserName: UILabel!
    @IBOutlet weak var newsUserApdateTime: UILabel!
    @IBOutlet weak var newsLikeImage: UIImageView!
    @IBOutlet weak var newsLikeLable: UILabel!
    @IBOutlet weak var seenViewLable: UILabel!
    
    
    var newsData: PhotoDataNews! {// NewsCellData!// {
        didSet {
            
            let ratio = (self.newsData.width) / UIScreen.main.bounds.width
            let height = (self.newsData.height) / ratio
           
            UIView.animate(withDuration: 0.5) {
                self.photoViewHeightConstraint.constant = height
                self.layoutIfNeeded()
            }
            self.imageParentView.frame.size.height = newsData.height
            self.newsImage.frame.size.height = newsData.height
           
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


}


