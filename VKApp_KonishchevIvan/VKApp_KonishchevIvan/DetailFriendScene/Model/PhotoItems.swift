//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 20.03.2022.
//

import UIKit

struct ImageAndLikeData {
    var image: String
    var likeStatus: Bool = false
    var likeLabel: Int = 0
    init(image: String, likeStatus: Bool, likeLabel: Int = 0) {
        self.image = image
        self.likeStatus = likeStatus
        self.likeLabel = likeLabel
    }
}


struct PhotoUser: Decodable {
    let response: PhotoResponse
}
struct PhotoResponse: Decodable {
    let items: [PhotoItems]
}
struct PhotoItems: Decodable {

    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case likes
        case date
        case photo = "sizes"
        case id
        case ownerId = "owner_id"
    }
    let ownerId: Int
    let date: Int
    let albumId: Int
    let id: Int
    let likes: PhotoLikes
    let photo: [PhotoData]
}
struct PhotoData: Decodable {
    
    let height: Double
    let width: Double
    let url: String
    let type: String
}
struct PhotoLikes: Decodable {
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
    let count: Int
    let userLikes: Int
}


