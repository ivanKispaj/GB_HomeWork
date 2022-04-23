//
//  UserGroupModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import Foundation

struct UserGroupModel: Decodable {
    let response: GroupResponse
}

struct GroupResponse: Decodable {
    let items: [ItemsGroup]
}

struct ItemsGroup: Decodable {
    enum CodingKeys: String, CodingKey {
        case activity
        case id
        case groupName = "name"
        case isClosed = "is_closed"
        case photoGroup = "photo_50"
    }
    let activity: String?
    let id: Int
    let groupName: String
    let isClosed: Int
    let photoGroup: String
}

