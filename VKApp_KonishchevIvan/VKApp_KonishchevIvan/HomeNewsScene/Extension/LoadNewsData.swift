//
//  LoadNewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
 
extension HomeNewsTableViewController {
    func loadNewsData() {
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
      InternetConnections(host: "api.vk.com", path: "/method/newsfeed.get").getUserNews() { [weak self] response in
          switch response {
// обработка ответа
          case .success(let result):
             
              var newsDatasPhoto: [CellType: [NewsCellData]] = [.photo: []] // конечный массив с данными
              var newsDatasLink: [CellType: [NewsCellData]] = [.link: []] // конечный массив с данными
              var newsDatasWall: [CellType: [NewsCellData]] = [.wall : []] // конечный массив с данными
              var newsDatasHistory:  [CellType: [NewsCellData]] = [.histroy: []]  // конечный массив с данными
              let items = result.response.items // Данные с новостями
              let profiles = result.response.profiles // данные с пользователями оставившими новость
              let groups = result.response.groups // данные о группах которые запостили новость
  // Перебираем массив items
              for item in items {

                  let ovnerId = item.sourceId
                  let date = item.date
                  let newsLike: NewsLikes?
                  let newsSeenCount: Int?
                  var newsDescription: String?
                  if let wall = item.wallPhotos {
                      newsLike = wall.items[0].likes
                      newsSeenCount = 0
                  }else {
                      newsLike = item.likes
                      newsSeenCount = item.views?.count
                  }
                  
                  if let text = item.text {
                      newsDescription = text
                  }else {
                      newsDescription = " "
                  }
                  
                  var newsUserLogo: String = ""
                  var newsUserName: String = ""
                  var online: Bool = false
                  var cellType: CellType = .photo
                  var newsText: String = ""
                  var albumId: Int = 0
                  var newsImage: String = ""
                  var newsTitle: String = ""
// получаем пользователя по id
                  if let user = getUserDataFromId(ovnerId, profiles: profiles) {
                       newsUserLogo = user.photo
                       newsUserName = user.fName + " " + user.lName
                      if user.online == 0 {
                           online = false
                      }else {
                           online = true
                      }
                  }else if let user = getGroupFromId(ovnerId, groups: groups) {
                       newsUserLogo = user.photo
                       newsUserName = user.name
                       online = false
                      
                  }
    // Усли новость с фото массивом
                  if let atachments = item.attachments {
                    
                      if let photoData = atachments[0].photoData {
                          cellType = .photo
                          newsText = photoData.text!
                          albumId = photoData.albumId
                          newsImage = getNewsPhoto(photoData.photoArray)
                          newsTitle = " "
    // если новость с ссылочным массивом ( игры )
                      }else if let link = atachments[0].link {
                          cellType = .link
                          newsText = link.title
                          newsDescription = link.description
                          albumId = link.photo.albumId
                          newsImage = getNewsPhoto(link.photo.photoArray)
                     } else if let video = atachments[0].video {
                          cellType = .photo
                          newsText = item.text!
                          newsTitle = video.title!
                         newsImage = getPhotoNewsHistory(video.image)
                      }
    // если новость со стены
                  }else if let wallPhoto = item.wallPhotos {
                      cellType = .wall
                      newsText = " "
                      newsDescription = wallPhoto.items[0].text
                      newsTitle = " "
                      newsImage = getNewsPhoto(wallPhoto.items[0].photo)
    // если новость с истории
                  }else if let copyHistory = item.copyHistory{
                      cellType = .histroy
                      newsText = copyHistory[0].attachments[0].video.title
                      newsDescription = copyHistory[0].attachments[0].video.description
                      albumId = 0
                      newsImage = getPhotoNewsHistory(copyHistory[0].attachments[0].video.newsImage)
                  }
                  let newsCellData = NewsCellData(ovnerId: ovnerId, date: date, newsLike: newsLike!, newsSeenCount: newsSeenCount!, newsDescription: newsDescription!, newsUserLogo: newsUserLogo, newsUserName: newsUserName, online: online, newsText: newsText, albumId: albumId, newsImage: newsImage, newsTitle: newsTitle)
                  switch cellType {
                  case .photo:
                      var arr = newsDatasPhoto[.photo]
                      arr?.append(newsCellData)
                      newsDatasPhoto[.photo] = arr
                  case .link:
                      var arr = newsDatasLink[.link]
                      arr?.append(newsCellData)
                      newsDatasLink[.link] = arr
                  case .wall:
                      var arr = newsDatasWall[.wall]
                      arr?.append(newsCellData)
                      newsDatasWall[.wall] = arr
                  case .histroy:
                      var arr = newsDatasHistory[.histroy]
                      arr?.append(newsCellData)
                      newsDatasHistory[.histroy] = arr
                  }
             }
              var arrayNewsData = [newsDatasPhoto]
              arrayNewsData.append(newsDatasLink)
              arrayNewsData.append(newsDatasWall)
              arrayNewsData.append(newsDatasHistory)
              
              
              self?.newsArray = arrayNewsData
          case .failure(_):
              print("ErrorLoadDataVK")
          }
      }
        func getUserDataFromId(_ ownerId: Int, profiles: [NewsProfiles]) -> NewsProfiles? {
            let profile = profiles.first { $0.id == ownerId }
            return profile
        }
        
        func getGroupFromId(_ ownerId: Int, groups: [NewsGroups]) -> NewsGroups? {
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
