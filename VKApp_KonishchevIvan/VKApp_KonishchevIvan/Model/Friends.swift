//
//  Friends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit

struct Friends {
    let name: String
    let avatar: UIImage?
    let userDetails: String?
    init (image: UIImage? = nil, name: String, userDetails: String? = nil) {
        self.name = name
        self.avatar = image
        self.userDetails = userDetails
    }
}
