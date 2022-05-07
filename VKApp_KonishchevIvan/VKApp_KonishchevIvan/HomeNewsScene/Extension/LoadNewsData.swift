//
//  LoadNewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

extension HomeNewsTableViewController {
    func loadNewsData() {
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
      InternetConnections(host: "api.vk.com", path: "/method/newsfeed.get").getUserNews() { [weak self] response in
          switch response {
// обработка ответа
          case .success(let result):
              let newsData = NewsData()
//              var newsDatasPhoto: [CellType: [NewsCellData]] = [.photo: []] // конечный массив с данными
//              var newsDatasLink: [CellType: [NewsCellData]] = [.link: []] // конечный массив с данными
//              var newsDatasWall: [CellType: [NewsCellData]] = [.wall : []] // конечный массив с данными
//              var newsDatasHistory:  [CellType: [NewsCellData]] = [.histroy: []]  // конечный массив с данными
//              let items = result.response.items // Данные с новостями
//              let profiles = result.response.profiles // данные с пользователями оставившими новость
//              let groups = result.response.groups // данные о группах которые запостили новость
//  // Перебираем массив items
//              for item in items {
//                  var newsCellData = NewsCellData()
//                  newsCellData.ownerId = item.sourceId
//                  newsCellData.date = item.date
//                  if let wall = item.wallPhotos {
//                      newsCellData.newsLikeCount = wall.items[0].likes!.count
//                      if wall.items[0].likes!.likeStatus == 1 {
//                          newsCellData.newsLikeStatus = true
//                      }
//                      newsCellData.newsSeenCount = 0
//                     
//                  }else {
//                      newsCellData.newsLikeCount = item.likes!.count
//                      newsCellData.newsSeenCount = item.views!.count
//                      if item.likes!.likeStatus == 1 {
//                          newsCellData.newsLikeStatus = true
//                      }
//                  }
//
//                  if let text = item.text {
//                      newsCellData.newsDescription = text
//                  }else {
//                      newsCellData.newsDescription = " "
//                  }
//                  var cellType: CellType = .photo
//                
//// получаем пользователя по id
//                  if let user = getUserDataFromId(newsCellData.ownerId, profiles: profiles) {
//                      newsCellData.newsUserLogo = user.photo
//                      newsCellData.newsUserName = user.fName + " " + user.lName
//                      if user.online == 1 {
//                          newsCellData.online = true
//                      }
//                  }else if let user = getGroupFromId(newsCellData.ownerId, groups: groups) {
//                      newsCellData.newsUserLogo = user.photo
//                      newsCellData.newsUserName = user.name
//                      newsCellData.online = false
//
//                  }
//    // Если новость с фото массивом
//                  let attachments = item.attachments
//                  if let atachments = item.attachments {
//
//                      if let photoData = atachments[0].photoData {
//                          cellType = .photo
//                          newsCellData.newsText = photoData.text!
//                          newsCellData.albumId = photoData.albumId
//                          newsCellData.newsImage = getNewsPhoto(photoData.photoArray)
//                          newsCellData.newsTitle = " "
//    // если новость с ссылочным массивом ( игры )
//                      }else if let link = atachments[0].link {
//                          cellType = .link
//                          newsCellData.newsText = link.title
//                          newsCellData.newsDescription = link.description
//                          newsCellData.albumId = link.photo.albumId
//                          newsCellData.newsImage = getNewsPhoto(link.photo.photoArray)
//                     } else if let video = atachments[0].video {
//                         cellType = .photo
//                         newsCellData.newsText = item.text!
//                         newsCellData.newsTitle = video.title!
//                         newsCellData.newsImage = getPhotoNewsHistory(video.image)
//                      }
//    // если новость со стены
//                  }else if let wallPhoto = item.wallPhotos {
//                      cellType = .wall
//                      newsCellData.newsText = " "
//                      newsCellData.newsDescription = wallPhoto.items[0].text
//                      newsCellData.newsTitle = " "
//                      newsCellData.newsImage = getNewsPhoto(wallPhoto.items[0].photo)
//    // если новость с истории
//                  }else if let copyHistory = item.copyHistory{
//                      cellType = .histroy
//                      newsCellData.newsText = copyHistory[0].attachments[0].video.title
//                      newsCellData.newsDescription = copyHistory[0].attachments[0].video.description
//                      newsCellData.albumId = 0
//                      newsCellData.newsImage = getPhotoNewsHistory(copyHistory[0].attachments[0].video.newsImage)
//                  }
//                  
//                  
//
//                  switch cellType {
//                    case .photo:
//                      newsData.photo.append(newsCellData)
//                        var arr = newsDatasPhoto[.photo]
//                        arr?.append(newsCellData)
//                        newsDatasPhoto[.photo] = arr
//                    case .link:
//                      newsData.link.append(newsCellData)
//                        var arr = newsDatasLink[.link]
//                        arr?.append(newsCellData)
//                        newsDatasLink[.link] = arr
//                    case .wall:
//                      newsData.wall.append(newsCellData)
//                        var arr = newsDatasWall[.wall]
//                        arr?.append(newsCellData)
//                        newsDatasWall[.wall] = arr
//                    case .histroy:
//                      newsData.histroy.append(newsCellData)
//                        var arr = newsDatasHistory[.histroy]
//                        arr?.append(newsCellData)
//                        newsDatasHistory[.histroy] = arr
//                    }
//             }
//              var arrayNewsData = [newsDatasPhoto]
//              arrayNewsData.append(newsDatasLink)
//              arrayNewsData.append(newsDatasWall)
//              arrayNewsData.append(newsDatasHistory)
//
//              
              //MARK: - Сохраняем в Realm
            //  self?.newsArray = arrayNewsData
          case .failure(_):
              print("ErrorLoadDataVK")
          }
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
        func getNewsPhoto(_ newsPhotoArray: [ImageArray]) -> String {
            if let url = newsPhotoArray.first(where: { $0.type == "y" }) {
                return url.url
            } else if let url = newsPhotoArray.first (where: { $0.type == "k" }) {
                return url.url
            }
            let url = newsPhotoArray.first(where: { $0.type == "q"})
            return url?.url ?? ""
            
        }
        func getPhotoNewsHistory(_ photoArray: [NewsImage]) -> String {
         
            let url = photoArray.first { $0.width > 300 }?.url
            return url ?? " "
        }
    }
}


//// MARK: - Private
//private extension HomeNewsTableViewController {
//    func saveNewsData(newsData: NewsData)  {
//         let realmDB = try!  Realm()
//    //    print(realmDB.configuration.fileURL!)
//            do {
//                    realmDB.beginWrite()
//                    realmDB.add(newsData)
//               try  realmDB.commitWrite()
//                
//            } catch let error as NSError {
//                print("Something went wrong: \(error.localizedDescription)")
//            }
//    }
//}

