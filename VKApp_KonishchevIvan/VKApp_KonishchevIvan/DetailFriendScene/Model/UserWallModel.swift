//
//  UserWallModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//

import Foundation

struct WallDatasArray {
    
}


struct UserWallModel: Decodable {
    let response: UserWallResponse
}

struct UserWallResponse: Decodable {
    let items: [UserWallItems]
}

struct UserWallItems: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case date
        case text
        case attachments
        case likes
        case views
        case copyHystory = "copy_history"
        
    }
    let id: Int
    let ownerId: Int
    let date: Int
    let text: String
    let attachments: [WallAttachments]?
    let copyHystory: [WallCopyHistory]?
    let likes: WallLikes?
    let views: WallViews?
    
}

struct WallCopyHistory:  Decodable {
    let attachments: [WallAttachments]?
}
struct WallAttachments: Decodable {
    let type: String
    let photo: WallPhoto?
    let link: WallLink?
   // let video: WallVideo?
    
    
}
struct WallVideo: Decodable {
    let description: String
}
struct WallLink: Decodable {
    let url: String
    let title: String
    let caption: String?
    let photo: WallPhoto?
}
struct WallPhoto: Decodable {
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date
        case photoId = "id"
        case ownerId = "owner_id"
        case sizes
    }
    let albumId: Int?
    let date: Int
    let photoId: Int
    let ownerId: Int
    let sizes: [WallSizes]
}
struct WallSizes: Decodable {
    let height: Int
    let width: Int
    let url: String
    let type: String?
}
struct WallLikes: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case userLike = "user_likes"
    }
    var count: Int
    var userLike: Int
}

struct WallViews: Decodable {
    let count: Int
}

struct UserWallProfiles: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosedProfile = "is_closed"
        case profilePhoto = "photo_50"
        case profilePhotoAlt = "photo"
        case online
        case status
        case lastSeen = "last_seen"
    }
    let id: Int
    let firstName: String
    let lastName: String
    let isClosedProfile: Bool
    let profilePhoto:String?
    let profilePhotoAlt: String
    let online: Int
    let status: String
    let lastSeen: WallLastSeen
    
}
struct WallLastSeen: Decodable {
    let platform: Int
    let time: Int
}
struct UserWallGroups: Decodable {
    
    
}
