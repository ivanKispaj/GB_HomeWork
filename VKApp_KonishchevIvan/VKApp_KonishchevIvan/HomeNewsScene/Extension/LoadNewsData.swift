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
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/newsfeed.get").getUserNews()
        }
        
        self.updateNewsView()
            
      }
    
     func setNotificationToken() {
        if let data = self.realmService.readData(NewsItems.self) {
            self.newsRealmToken = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("Signed")
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
        var newsDatasPhoto: [CellType: [NewsCellData]] = [.photo: []] // конечный массив с данными
        var newsDatasLink: [CellType: [NewsCellData]] = [.link: []] // конечный массив с данными
        var newsDatasWall: [CellType: [NewsCellData]] = [.wall : []] // конечный массив с данными
        var newsDatasHistory:  [CellType: [NewsCellData]] = [.histroy: []]  // конечный массив с данными
        
        if let profiles = self.realmService.readData(NewsResponse.self)?.first?.profiles {
            if let groups = self.realmService.readData(NewsResponse.self)?.first?.groups {
                if let items = self.realmService.readData(NewsResponse.self)?.first?.items {
                    
                    for item in items {
                        var newsCellData = NewsCellData()
                        newsCellData.ownerId = item.sourceId
                        newsCellData.date = item.date

                        
                        if let wall = item.wallPhotos {
                            newsCellData.newsLikeCount = wall.items[0].likes!.count
                            if wall.items[0].likes!.likeStatus == 1 {
                                newsCellData.newsLikeStatus = true
                            }
                            newsCellData.newsSeenCount = 0
                           
                        }else {
                            newsCellData.newsLikeCount = item.likes!.count
                            newsCellData.newsSeenCount = item.views!.count
                            if item.likes!.likeStatus == 1 {
                                newsCellData.newsLikeStatus = true
                            }
                        }
                        
                        if let text = item.text {
                            newsCellData.newsDescription = text
                        }else {
                            newsCellData.newsDescription = " "
                        }
                        var cellType: CellType = .photo
                      
      // получаем пользователя по id
                      
                        if let user = getUserDataFromId(newsCellData.ownerId, profiles: profiles) {
                            newsCellData.newsUserLogo = user.photo
                            newsCellData.newsUserName = user.fName + " " + user.lName
                            if user.online == 1 {
                                newsCellData.online = true
                            }
                        }else if let user = getGroupFromId(newsCellData.ownerId, groups: groups) {
                            newsCellData.newsUserLogo = user.photo
                            newsCellData.newsUserName = user.name
                            newsCellData.online = false

                        }
                        
                        if let atachments = item.attachments.first {

                            if let photoData = atachments.photoData {
                                cellType = .photo
                                newsCellData.newsText = photoData.text
                                newsCellData.albumId = photoData.albumId
                                newsCellData.newsImage = getNewsPhoto(photoData.photoArray)
                                newsCellData.newsTitle = " "
          // если новость с ссылочным массивом ( игры )
                            }else if let link = atachments.link {
                                cellType = .link
                                newsCellData.newsText = link.title
                                newsCellData.newsDescription = link.description
                                newsCellData.albumId = link.photo!.albumId
                                newsCellData.newsImage = getNewsPhoto(link.photo!.photoArray)
                           } else if let video = atachments.video {
                               cellType = .photo
                               newsCellData.newsText = item.text!
                               newsCellData.newsTitle = video.title!
                               newsCellData.newsImage = getPhotoNewsHistory(video.image)
                            }
          // если новость со стены
                        }else if let wallPhoto = item.wallPhotos {
                            cellType = .wall
                            newsCellData.newsText = " "
                            newsCellData.newsDescription = wallPhoto.items[0].text
                            newsCellData.newsTitle = " "
                            newsCellData.newsImage = getNewsPhoto(wallPhoto.items[0].photo)
          // если новость с истории
                        }else if let copyHistory = item.newsCopyHistory.first {
                            cellType = .histroy
                            newsCellData.newsText = (copyHistory.attachments.first?.video!.title)!
                            newsCellData.newsDescription = (copyHistory.attachments.first?.video!.description)!
                            newsCellData.albumId = 0
                            newsCellData.newsImage = getPhotoNewsHistory((copyHistory.attachments.first?.video!.newsImage)!)
                        }
                     
                        
                            switch cellType {
                            case .photo:
                               // newsData.photo.append(newsCellData)
                                var arr = newsDatasPhoto[.photo]
                                arr?.append(newsCellData)
                                newsDatasPhoto[.photo] = arr
                            case .link:
                             //   newsData.link.append(newsCellData)
                                var arr = newsDatasLink[.link]
                                arr?.append(newsCellData)
                                newsDatasLink[.link] = arr
                            case .wall:
                            //    newsData.wall.append(newsCellData)
                                var arr = newsDatasWall[.wall]
                                arr?.append(newsCellData)
                                newsDatasWall[.wall] = arr
                            case .histroy:
                           //     newsData.histroy.append(newsCellData)
                                var arr = newsDatasHistory[.histroy]
                                arr?.append(newsCellData)
                                newsDatasHistory[.histroy] = arr
                            }
                                     }
                                      var arrayNewsData = [newsDatasPhoto]
                                      arrayNewsData.append(newsDatasLink)
                                      arrayNewsData.append(newsDatasWall)
                                      arrayNewsData.append(newsDatasHistory)
                    self.newsArray = arrayNewsData
                    
                    
                }
            }
        }
    }
    
    private func getUserDataFromId(_ ownerId: Int, profiles: List<NewsProfiles>) -> NewsProfiles? {
        let profile = profiles.first { $0.id == ownerId }
        return profile
    }
    
    private func getGroupFromId(_ ownerId: Int, groups: List<NewsGroups>) -> NewsGroups? {
        var id = ownerId
        id.negate()
        let group = groups.first { $0.id == id }
        return group
    }

    private func getNewsPhoto(_ newsPhotoArray: List<ImageArray>) -> String {
        if let url = newsPhotoArray.first(where: { $0.type == "y" }) {
            return url.url
        } else if let url = newsPhotoArray.first (where: { $0.type == "k" }) {
            return url.url
        }
        let url = newsPhotoArray.first(where: { $0.type == "q"})
        return url?.url ?? ""
        
    }

    private func getPhotoNewsHistory(_ photoArray: List<NewsImage>) -> String {
     
        let url = photoArray.first { $0.width > 300 }?.url
        return url ?? " "
    }
}





