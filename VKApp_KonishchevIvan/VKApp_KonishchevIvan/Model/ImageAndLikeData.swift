//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 20.03.2022.
//

import UIKit

struct ImageAndLikeData {
    let image: UIImage!
    var likeStatus: Bool = false
    var likeLabel: Int? = 0
    init(image: UIImage, likeStatus: Bool, likeLabel: Int? = 0) {
        self.image = image
        self.likeStatus = likeStatus
        self.likeLabel = likeLabel
    }
}
