//
//  SinglePhotoAndTextTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
import AVKit

class SinglePhotoAndTextTableViewCell: UITableViewCell, DequeuableProtocol {
 
    
    @IBOutlet weak var parentViewImage: UIView!
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
  

    func configureCellForPhoto(from data: NewsCellData, linkStatus: Bool, image: UIImage) {
        self.newsImage.image = image
        if let imageData = data.newsImage.first {
            let ratio = (imageData.width) / UIScreen.main.bounds.width
            let height = (imageData.height) / ratio
            self.photoViewHeightConstraint.constant = height
        }
        
        self.newsTextView.text = data.newsText
        self.newsUserName.text = data.newsUserName
        self.newsLikeLable.text = String(data.newsLikeCount)
        self.newsUserAvatar.image = UIImage(data: data.newsUserLogo)
        self.imageParentView.backgroundColor = .clear
        self.newsUserApdateTime.text = data.date.unixTimeConvertion()
        self.seenViewLable.text = String(data.newsSeenCount)
        if linkStatus {
            self.lableOnPhoto.text = data.lableOnPhoto
            self.lableUserNameOnPhoto.text = data.lableUserNameOnPhoto
            self.imageParentView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.4388283451)
        }else {
            self.lableOnPhoto.text = ""
            self.lableUserNameOnPhoto.text = ""
        }
    }
 

}

