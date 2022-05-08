//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

enum SectionType {
    case Friends
    case Gallary
    case SingleFoto
    case link
    case video
    case newsText
    
}

struct UserDetailsTableData {

    let sectionType: SectionType
    var sectionData: DetailsSectionData
    
}

struct DetailsSectionData {
    let id: Int
    let ownerId: Int
    let date: Int
    let textNews: String
    var likes: WallLikes
    let views: WallViews?
    let urlNewsImage: [String]?
    let titleNews: String?
    let captionNews: String?
    let friends: [Friend]?
    let photo: [ImageAndLikeData]?
    let linkUrl:  String?

    init( id: Int, ownerId: Int, date: Int, textNews: String, likes: WallLikes, views: WallViews?, urlNewsImage: [String]?, titleNews: String?, captionNews: String?, link: String,friends: [Friend]? = nil, photo: [ImageAndLikeData] ) {
        self.id = id
        self.ownerId = ownerId
        self.date = date
        self.textNews = textNews
        self.likes = likes
        self.views = views
        self.urlNewsImage = urlNewsImage
        self.titleNews = titleNews
        self.captionNews = captionNews
        self.linkUrl = link
        self.friends = friends
        self.photo = photo
    }
    init( id: Int = 0, ownerId: Int = 0, date: Int = 0, textNews: String = "", likes: WallLikes = WallLikes(), views: WallViews? = nil ,urlNewsImage: [String]? = [], titleNews: String? = "", captionNews: String? = "", link: String? = "",friends: [Friend] , photo: [ImageAndLikeData]? = nil) {
        self.id = id
        self.ownerId = ownerId
        self.date = date
        self.textNews = textNews
        self.likes = likes
        self.views = views
        self.urlNewsImage = urlNewsImage
        self.titleNews = titleNews
        self.captionNews = captionNews
        self.linkUrl = link
        self.friends = friends
        self.photo = photo
    }
    init( id: Int = 0, ownerId: Int = 0, date: Int = 0, textNews: String = "", likes: WallLikes = WallLikes(), views: WallViews? = nil ,urlNewsImage: [String]? = [], titleNews: String? = "", captionNews: String? = "", link: String? = "",friends: [Friend]? = nil , photo: [ImageAndLikeData]) {
        self.id = id
        self.ownerId = ownerId
        self.date = date
        self.textNews = textNews
        self.likes = likes
        self.views = views
        self.urlNewsImage = urlNewsImage
        self.titleNews = titleNews
        self.captionNews = captionNews
        self.linkUrl = link
        self.friends = friends
        self.photo = photo
    }
}
