//
//  Friends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit

struct Friendss: Decodable {
    let response: Response
}

struct Response: Decodable {
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
    }
    let photo50: String
    let city: City?
    let fName: String
    let lName: String
    let id: Int
    let online: Int
    let lastSeen: LastSeen?
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

