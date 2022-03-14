//
//  ControlForLike.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class NewsControlForLike: UIControl {
    @IBOutlet weak var likeHeart: UIImageView!
    @IBOutlet weak var likeLabelNews: UILabel!

    var isLike: Bool = false
    var countLikes: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(setLike))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }

    @objc func setLike(_ tap: UITapGestureRecognizer) {
        if self.isLike {
            self.likeHeart.image = UIImage(systemName: "suit.heart")
            self.likeHeart.tintColor = UIColor.systemGray2
            self.countLikes -= 1
        }else {
            self.likeHeart.image = UIImage(systemName: "suit.heart.fill")
            self.likeHeart.tintColor = UIColor.red
            self.countLikes += 1
        }
        self.isLike.toggle()
        self.likeLabelNews.text = String(self.countLikes)

    }
}
