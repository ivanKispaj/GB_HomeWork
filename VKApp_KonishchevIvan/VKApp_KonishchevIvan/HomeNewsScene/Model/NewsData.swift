//
//  NewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
enum CellType {
    case photo
    case link
    
}
struct NewsData {
    let cellType: CellType
    let newsText: String?
    var newsImage: String
    var newsLike: NewsLikes
    let newsUser: NewsProfiles
    let newsSeen: Int
    let title: String
    let description: String?
}

struct NewsModel:Decodable {
    let response: NewsResponse
}
struct NewsResponse: Decodable {
    let items: [NewsItems]
    let profiles: [NewsProfiles]
}

struct NewsItems: Decodable{
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case attachments
        case postId = "post_id"
        case type
        case likes
        case views

    }
    let sourceId: Int
    let date: Int
    let attachments: [NewsAttachments]
    let postId: Int
    let type: String
    let likes: NewsLikes
    let views: NewsViews

}
struct NewsViews: Decodable {
    let count: Int
}
struct NewsAttachments: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case photoData = "photo"
        case link
    }
    let type: String
    let photoData: NewsPhotosData?
    let link: NewsLink?
}

struct NewsLink: Decodable {
    let url: String
    let title: String
    let caption: String
    let description: String
    let photo: NewsPhotosData
}
struct NewsPhotosData: Decodable {
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date
        case id
        case ownerId = "owner_id"
        case text
        case photoArray = "sizes"
       }
    let albumId: Int
    let date: Int
    let id: Int
    let ownerId: Int
    let text: String?
    let photoArray: [ImageArray]
   
}

struct ImageArray: Decodable {
 
    let height: Int
    let width: Int
    let url: String
    let type: String
}

struct NewsLikes: Decodable {
    var count: Int
    
}

struct NewsProfiles: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case fName = "first_name"
        case lName = "last_name"
        case photo = "photo_50"
        case screenName = "screen_name"
        case online
        case inlineInfo = "online_info"
    }
    let id: Int
    let fName: String
    let lName: String
    let photo: String
    let screenName: String
    let online: Int
    let inlineInfo: NewsOnlineInfo
}

struct NewsOnlineInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
    }
    let isOnline: Bool
    let isMobile: Bool
    let lastSeen: Int
}




