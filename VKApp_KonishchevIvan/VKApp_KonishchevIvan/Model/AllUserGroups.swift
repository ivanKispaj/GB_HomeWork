//
//  AllUserGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

struct AllUserGroups:Equatable {
    let nameGroup: String
    let imageGroup: UIImage?
    init(nameGroup: String, logoGroup: UIImage? = nil){
        self.nameGroup = nameGroup
        self.imageGroup = logoGroup
    }
}
