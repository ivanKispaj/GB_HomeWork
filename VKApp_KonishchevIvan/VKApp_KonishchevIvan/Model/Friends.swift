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
    init (character: String? = nil, image: UIImage? = nil, name: String) {
        self.name = name
        self.avatar = image
    }
}
