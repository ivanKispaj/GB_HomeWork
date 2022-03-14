//
//  ControlForLike.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class ControlForLike: UIControl {

    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeLable: UILabel!
   
    var isLike: Bool = false
    var counLikes: Int = 0
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(setLike))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    @objc func setLike(_ tap: UITapGestureRecognizer) {

        if self.isLike {
            self.likeImage.image = UIImage(systemName: "suit.heart")
            self.likeImage.tintColor = UIColor.systemGray2
            self.counLikes -= 1
        }else {
            self.likeImage.image = UIImage(systemName: "suit.heart.fill")
            self.likeImage.tintColor = UIColor.red
            self.counLikes += 1
        }
        self.isLike.toggle()
        self.likeLable.text = String(self.counLikes)

    }
}
