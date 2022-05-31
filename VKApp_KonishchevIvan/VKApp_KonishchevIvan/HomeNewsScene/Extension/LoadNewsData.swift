//
//  LoadNewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

extension HomeNewsTableViewController {
    
    func loadNewsData()  {
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
       
        self.updateNewsView()
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/newsfeed.get").getUserNews()
        }
      }
    
     func setNotificationToken() {
        if let data = self.realmService.readData(NewsItems.self) {
            self.newsRealmToken = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("NewsVC Signed")
                case let .update(_, deletions, insertions, _):
                    if deletions.count != 0 || insertions.count != 0 {
                        self.updateNewsView()                    }
                    
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
    private func updateNewsView()  {
      
        guard let profiles = self.realmService.readData(NewsResponse.self)?.first?.profiles else { return }
        guard let groupes = self.realmService.readData(NewsResponse.self)?.first?.groups else { return }
        guard let items = self.realmService.readData(NewsResponse.self)?.first?.items else { return }
        guard  items.count > 0 else { return }
        
        var newsDatasToController: [[CellType: NewsCellData]] = []
     
        for item in items {
            var newsDatas: [CellType: NewsCellData] = [ : ]
            var cellType: CellType = .uncnown
            guard let newsUserData = getUserData(from: item.sourceId, profiles: profiles, groupes: groupes) else { continue }
            var newsCellData = NewsCellData()
            newsCellData.date = item.date
            newsCellData.ownerId = item.sourceId
        
            if let likes = item.likes {
                newsCellData.newsLikeCount = likes.count
                if likes.likeStatus == 1 {
                    newsCellData.newsLikeStatus = true
                }
            }
            
            if let views = item.views {
                newsCellData.newsSeenCount = views.count
            }
            
            newsCellData.isOnline = newsUserData.isOnline
            newsCellData.isBanned = newsUserData.isBanned
            newsCellData.newsUserName = newsUserData.userName
            newsCellData.newsUserLogo = newsUserData.userLogo
            newsCellData.newsText = item.text ?? ""
            if item.type == "post" && item.attachments.count == 0 && item.newsCopyHistory.count == 0 {
                cellType = .post
                newsCellData.newsText = item.text ?? ""
                
            }else if item.type == "post" && item.attachments.count == 1 && item.newsCopyHistory.count == 0 {
               
                if item.attachments[0].type == "photo" {
                    cellType = .photo
                    let photoData = item.attachments[0].photoData!.photoArray
                    if let data = getNewsPhoto(photoData) {
                        newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                    }
                    newsCellData.albumId = item.attachments[0].photoData?.albumId ?? 0
                    
                }else if item.attachments[0].type == "link" {
                    cellType = .link
                    if let link = item.attachments[0].link {
                        newsCellData.lableOnPhoto = link.title
                        newsCellData.lableUserNameOnPhoto = newsUserData.userName
                        if let data = getNewsPhoto(link.photo!.photoArray) {
                            newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                        }
                    }
                }else if item.attachments[0].type == "video" {
                    cellType = .video
                    if let video = item.attachments[0].video {
                        newsCellData.accessKey = video.accessKey!
                        newsCellData.trackCode = video.trackCode!
                        newsCellData.videoId = video.videoId
                        if let data = getFirstFrame(from: video.firstFrame) {
                            newsCellData.firstFrame = PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width))
                        }
                        if video.type == "live" {
                            newsCellData.videoType = .live
                        }
                    }
                }
                
                
            }else if item.type == "post" && item.attachments.count == 2 && item.newsCopyHistory.count == 0 {
                if item.attachments[0].type == "photo" && item.attachments[1].type == "link" {
                    cellType = .photoLink
                    let photoData = item.attachments[0].photoData!.photoArray
                    if let data = getNewsPhoto(photoData) {
                        newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                    }
                    newsCellData.albumId = item.attachments[0].photoData?.albumId ?? 0
                    
                    newsCellData.newsLink = item.attachments[1].link?.url ?? ""
                    
                }
            }else if item.type == "post" && item.attachments.count > 2 && item.newsCopyHistory.count == 0 {
                let photo = item.attachments.filter({ $0.type == "photo" })
                if photo.count == item.attachments.count {
                    cellType = .gallary
                    for attach in item.attachments {
                        let photoData = attach.photoData!.photoArray
                        if let data = getNewsPhoto(photoData) {
                            newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                        }
                       
                    }
                    newsCellData.albumId = item.attachments[0].photoData?.albumId ?? 0
                    
                    
                }
            }else if item.type == "post" && item.attachments.count == 0, let copyHistory = item.newsCopyHistory.first {
                if copyHistory.attachments.count == 1 {
                    let attachments = copyHistory.attachments

                    switch attachments[0].type {
                        
                    case "photo":
                        cellType = .photo
                       
                        let photoData = attachments[0].photoData!.photoArray
                        
                        if let data = getNewsPhoto(photoData) {
                            newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                        }
                        newsCellData.albumId = attachments[0].photoData?.albumId ?? 0
                        
                    case "link":
                        cellType = .link
                        if let link = attachments[0].link {
                            newsCellData.lableOnPhoto = link.title
                            newsCellData.lableUserNameOnPhoto = newsUserData.userName
                            if let data = getNewsPhoto(link.photo!.photoArray) {
                                newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                            }
                        }
                        
                    case "video":
                        cellType = .video
                        
                        if let video = attachments[0].video {
                            newsCellData.accessKey = video.accessKey!
                            newsCellData.trackCode = video.trackCode!
                            newsCellData.videoId = video.videoId
                            if let data = getFirstFrame(from: video.firstFrame) {
                                newsCellData.firstFrame = PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width))
                            }
                            if video.type == "live" {
                                newsCellData.videoType = .live
                            }
                        }
                        
                    default:
                        cellType = .uncnown
                    }
                    
                }else if copyHistory.attachments.count == 2 {
                    let attachments = copyHistory.attachments
                    if attachments[0].type == "photo" && attachments[1].type == "link" {
                        cellType = .photoLink
                        
                        let photoData = attachments[0].photoData!.photoArray
                        if let data = getNewsPhoto(photoData) {
                            newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                        }
                        newsCellData.albumId = attachments[0].photoData?.albumId ?? 0
                        newsCellData.newsLink = attachments[1].link?.url ?? ""
                    }
                    
                }else if copyHistory.attachments.count > 2 {
                    let photo = copyHistory.attachments.filter({ $0.type == "photo" })
                    if photo.count == copyHistory.attachments.count {
                        cellType = .gallary
                    }
                    for attach in copyHistory.attachments {
                        let photoData = attach.photoData!.photoArray
                        if let data = getNewsPhoto(photoData) {
                            newsCellData.newsImage.append(PhotoDataNews(url: data.url, height: CGFloat(data.height), width: CGFloat(data.width)))
                        }
                       
                    }
                    newsCellData.albumId = item.attachments[0].photoData?.albumId ?? 0
                    
                }
                
               
                
            
            }
            newsDatas = [cellType: newsCellData]
            newsDatasToController.append(newsDatas)
         
        }
        self.newsData = newsDatasToController
    }
    


    private func getFirstFrame(from data: List<NewsVideoFirstFrame>) -> NewsVideoFirstFrame? {
        if let frameData = data.first(where: { $0.width < 1000 }) {
            return frameData
        }
        return nil
    }
    
    private func getNewsPhoto(_ newsPhotoArray: List<ImageArray>) -> ImageArray? {
        if let data = newsPhotoArray.last(where: { $0.width < 1000 }) {
     
            return data
        }
        
        return nil
    }

    private func getPhotoNewsHistory(_ photoArray: List<NewsImage>) -> NewsImage? {
     
        let data = photoArray.last { $0.width < 1000 }
        return data ?? nil
    }
    
    private func getUserData(from sourceId: Int, profiles: List<NewsProfiles> , groupes: List<NewsGroups>) ->  NewsUserData? {
        var group = sourceId
        group.negate()
        if let group = groupes.first(where: { $0.id == group }) {
           
            return NewsUserData(userLogo: group.photo, userName: group.name, isOnline: false, isBanned: false, screenName: group.screenName)
        }else if let profile = profiles.first(where: { $0.id == sourceId }) {
            let name = profile.fName + " " + profile.lName
            var isOnline = false
            var isBanned = false
            if profile.online == 1 {
                isOnline = true
            }
            if profile.banned != nil {
                isBanned = true
            }
            return NewsUserData(userLogo: profile.photo , userName: name, isOnline: isOnline, isBanned: isBanned, screenName: profile.screenName!)
        }
        return nil
    }
    

    
    
}





