//
//  LikeControll.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 27.02.2022.
//

import UIKit

class LikeControll: UIControl {

    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeLable: UILabel!
    var isLike: Bool = false
    
    override func awakeFromNib() {
        likeImage.tintColor = .systemGray5
        likeLable.text = ""

    }
}
