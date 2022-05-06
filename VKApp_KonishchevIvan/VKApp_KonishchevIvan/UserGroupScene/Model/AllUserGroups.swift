//
//  AllUserGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

struct AllUserGroups:Equatable {
    var nameGroup: String
    let imageGroup: String
    let activity: String
    init(nameGroup: String, logoGroup: String, activity: String ){
        self.nameGroup = nameGroup
        self.imageGroup = logoGroup
        self.activity = activity
    }
}