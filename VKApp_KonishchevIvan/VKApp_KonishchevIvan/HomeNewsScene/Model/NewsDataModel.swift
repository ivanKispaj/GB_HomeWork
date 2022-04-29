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
    case wall
    case histroy
}
//MARK: - Model для отображения страницы новостей
struct NewsCellData {
    var ovnerId: Int
    var date: Int
    var newsLike: NewsLikes
    var newsSeenCount: Int
    var newsDescription: String
    var newsUserLogo: String
    var newsUserName: String
    var online: Bool
    var newsText: String
    var albumId: Int
    var newsImage: String
    var newsTitle: String
    
  
 
}

//MARK: -  Модель для парсинга новостей!!!!
struct NewsDataModel:Decodable {
    let response: NewsResponse // response
}
struct NewsResponse: Decodable {
    let items: [NewsItems]  // items
    let profiles: [NewsProfiles]  //profiles
    let groups: [NewsGroups]  //groups
}

//MARK: -  items data model
struct NewsItems: Decodable{
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"  // id profiles or (Groups with  -sours_id )
        case date                   // дата
        case attachments            // опционально либо copy_history вместо него
        case copyHistory = "copy_history"
        case postId = "post_id"
        case type
        case likes
        case views
        case text
        case wallPhotos = "photos"
    }
    let sourceId: Int
    let date: Int
    let attachments: [NewsAttachments]?
    let copyHistory: [NewsCopyHistory]?
    let postId: Int
    let type: String
    let likes: NewsLikes?
    let views: NewsViews?
    let text: String?
    let wallPhotos: NewsWallPhotos?

}

struct NewsWallPhotos: Decodable {
    let items: [NewsWallPhotoData]
}

struct NewsCopyHistory: Decodable {
    enum codingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case date
        case attachments
    }
    let ownerId: Int?
    let date: Int
    let attachments: [NewsHistoryAttachments]
}

struct NewsHistoryAttachments: Decodable {
    let video: NewsHistoryVideo
    
}

struct NewsHistoryVideo: Decodable {
    enum CodingKeys: String, CodingKey {
        case accesKey = "access_key"
        case date
        case description
        case duration
        case newsImage = "image"
        case title

    }
    let accesKey: String?
    let date: Int
    let description: String
    let duration: Int?
    let newsImage: [NewsImage]
    let title: String
}

struct NewsImage: Decodable {
    let url: String
    let width: Int
    let height: Int
}
struct NewsWallPhotoData: Decodable {
    enum CodingKeys: String, CodingKey  {
        case albumId = "album_id"
        case date
        case idPhoto = "id"
        case photo = "sizes"
        case text
        case likes
    }
    let albumId: Int
    let date: Int
    let idPhoto: Int
    let photo: [ImageArray]
    let likes: NewsLikes
    let text: String
}
struct NewsViews: Decodable {
    let count: Int
}
struct NewsAttachments: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case photoData = "photo"
        case link
        case video
    }
    let type: String
    let photoData: NewsPhotosData?
    let link: NewsLink?
    let video: NewsVideo?

}
struct NewsVideo:  Decodable {
    let image: [NewsImage]
    let title: String?
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
    enum CodingKeys: String, CodingKey {
        case count
        case likeStatus = "user_likes"
    }
    var count: Int
    var likeStatus: Int
}

struct NewsProfiles: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case fName = "first_name"
        case lName = "last_name"
        case photo = "photo_50"
        case screenName = "screen_name"
        case online
        case onlineInfo = "online_info"
        case banned = "deactivated"
    }
    let id: Int
    let fName: String
    let lName: String
    let photo: String
    let screenName: String?
    let online: Int
    let onlineInfo: NewsOnlineInfo?
    let banned: String?
}

struct NewsOnlineInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
    }
    let isOnline: Bool
    let isMobile: Bool
    let lastSeen: Int?
}


struct NewsGroups: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
    }
    let id: Int
    let name: String
    let photo: String
}

