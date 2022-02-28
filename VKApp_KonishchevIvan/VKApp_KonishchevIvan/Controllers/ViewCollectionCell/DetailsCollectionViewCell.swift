//
//  DetailsCollectionViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {

    var countLike: Int = 0
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var likeControll: LikeControll!
    @IBOutlet weak var tapContainerL: UIView!
    override func awakeFromNib() {
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapLikeImage))
                tap.numberOfTapsRequired = 2
                tapContainerL.addGestureRecognizer(tap)
            }
    @objc func tapLikeImage(_ : UITapGestureRecognizer ){
        likeControll.isLike.toggle()
        if likeControll.isLike {
            countLike += 1
            likeControll.likeImage.tintColor = .red
            likeControll.likeLable.text = "Нравится: \(countLike)"
        }else {
            countLike -= 1
            likeControll.likeImage.tintColor = .systemGray5
            likeControll.likeLable.text = "Нравится: \(countLike)"
        }
    }
          
    }
  


