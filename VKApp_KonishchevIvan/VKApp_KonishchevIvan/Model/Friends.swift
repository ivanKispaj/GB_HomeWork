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
    let city: String?
    let details: String?
    let hisFriends: [HisFirends]
    init (character: String? = nil, image: UIImage? = nil, name: String, city: String = "", details: String = "", hisFriends: [HisFirends] ) {
        self.name = name
        self.avatar = image
        self.city = city
        self.details = details
        self.hisFriends = hisFriends
    }
}
