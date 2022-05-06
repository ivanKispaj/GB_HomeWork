//
//  Friends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit
import RealmSwift

final class FriendArray: Object {
    var friendArray = List<Friend>()
}
final class Friend: Object {
    @objc dynamic var userName: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var city: String = ""
    @objc dynamic var lastSeenDate: Double = 0
    @objc dynamic var isClosedProfile: Bool = false
    @objc dynamic var isBanned: Bool = false
    @objc dynamic var online: Bool = false
    @objc dynamic var status: String = " "
    
}
struct Friends: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let items: [FriendsItems]
}

struct FriendsItems: Decodable {
    enum CodingKeys: String, CodingKey {
        case city
        case fName = "first_name"
        case lName = "last_name"
        case photo50 = "photo_50"
        case id
        case online
        case lastSeen = "last_seen"
        case isClosedProfile = "is_closed"
        case banned = "deactivated"
        case status
    }
    let photo50: String
    let city: City?
    let fName: String
    let lName: String
    let id: Int
    let online: Int
    let lastSeen: LastSeen?
    let isClosedProfile: Bool?
    let banned: String?
    let status: String?
}

struct City: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    let id: Int
    let title: String
}

struct LastSeen: Decodable {
    enum CodingKeys: String, CodingKey {
        case time
        case platform
    }
    let platform: Int
    let time: Double
}
