//
//  LoadNewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

extension HomeNewsTableViewController {
    func loadNewsData() async {
        
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
        
   
            InternetConnections(host: "api.vk.com", path: "/method/newsfeed.get").getUserNews()

             self.notificationToken()
        
      }
        func getUserDataFromId(_ ownerId: Int, profiles: List<NewsProfiles>) -> NewsProfiles? {
            let profile = profiles.first { $0.id == ownerId }
            return profile
        }
        
        func getGroupFromId(_ ownerId: Int, groups: List<NewsGroups>) -> NewsGroups? {
            var id = ownerId
            id.negate()
            let group = groups.first { $0.id == id }
            return group
        }
    
        func getNewsPhoto(_ newsPhotoArray: List<ImageArray>) -> String {
            if let url = newsPhotoArray.first(where: { $0.type == "y" }) {
                return url.url
            } else if let url = newsPhotoArray.first (where: { $0.type == "k" }) {
                return url.url
            }
            let url = newsPhotoArray.first(where: { $0.type == "q"})
            return url?.url ?? ""
            
        }
    
        func getPhotoNewsHistory(_ photoArray: List<NewsImage>) -> String {
         
            let url = photoArray.first { $0.width > 300 }?.url
            return url ?? " "
        }
    
    private func notificationToken()  {
        do {
            let realm = try  Realm()
            let objcItems = realm.objects(NewsItems.self)
            self.newsRealmToken = objcItems.observe { (changes: RealmCollectionChange) in
               switch changes {
               case .initial( let results ):
                   print("Initial NewsRealm")
               case let .update(results, deletions, insertions, modifications):
                 self.updateNewsView()
                  print("Update RealmNews")
               case .error(let error):
                   print(error)
               }
             print("changet")
           
        }
        }catch {
            
        }
 
    }
  private func loadNewsItems()  ->  List<NewsItems>?{
            do {
                let realm = try  Realm()
                let newsItems = realm.objects(NewsResponse.self).first
                return newsItems?.items
            }catch {
                print(error)
            }
            return nil
        }
    private func loadNewsProfiles()  ->  List<NewsProfiles>?{
              do {
                  let realm = try  Realm()
                  let newsItems = realm.objects(NewsResponse.self).first
                  return newsItems?.profiles
              }catch {
                  print(error)
              }
              return nil
          }
    
    private func loadNewsGroups()  ->  List<NewsGroups>?{
              do {
                  let realm = try  Realm()
                  let newsItems = realm.objects(NewsResponse.self).first
                  
                  return newsItems?.groups
              }catch {
                  print(error)
              }
              return nil
          }
    
    private func updateNewsView()  {
        
            var newsDatasPhoto: [CellType: [NewsCellData]] = [.photo: []] // конечный массив с данными
            var newsDatasLink: [CellType: [NewsCellData]] = [.link: []] // конечный массив с данными
            var newsDatasWall: [CellType: [NewsCellData]] = [.wall : []] // конечный массив с данными
            var newsDatasHistory:  [CellType: [NewsCellData]] = [.histroy: []]  // конечный массив с данными
            if let items =  loadNewsItems() {
                if let profiles =  loadNewsProfiles() {
                    if let groups =  loadNewsGroups(){
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
}





