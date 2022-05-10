//
//  loadUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//
//MARK: - Необходимо доработать контроллер для разных типов ячеек таблицы!!!! Еще не финальная часть!

import UIKit
import RealmSwift

extension DetailUserTableViewController {

    func loadUserWall () async {
   
        InternetConnections(host: "api.vk.com", path: "/method/wall.get").getUserWall(for: String(self.friendsSelectedd.id))
        
        self.setNotificationtokenWall()
        
        if let items = await self.loadUserWallFromRealm(from: self.friendsSelectedd.id) {
            self.updateWallData(from: items)
        }

    }
    
   private func getPhotoUrl(_ photoArr: List<WallSizes>) -> WallSizes {
        if let photoData = photoArr.first(where: { $0.type == "y" }) {
            return photoData
        } else if let photoData = photoArr.first (where: { $0.type == "x" }) {
            return photoData
        }else if let photoData = photoArr.first (where: { $0.type == "k" }) {
            return photoData
        } else if let photoData = photoArr.first(where: { $0.type == "q"}) {
            return photoData
        }else if let photoData = photoArr.first(where: { $0.width > 200}) {
            return photoData
        }else if let photoData = photoArr.first(where: { $0.width > 130}) {
            return photoData
        }
        let photoData = photoArr.first(where: { $0.width > 90})
       return photoData!
    }
    
   private func getPhotoNewsHistory(_ photoArray: [WallSizes]) -> String {
     
        let url = photoArray.first { $0.width > 300 }?.url
        return url ?? " "
    }
//MARK: - setNotificationTokenWall
    private func setNotificationtokenWall() {
        do {
            let realm = try Realm()
            let data = realm.objects(UserWallResponse.self)
                .where { $0.id == self.friendsSelectedd.id}
            self.notifiTokenWall = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial( let results ):
                    print("Initial NewsRealm")
                case let .update(results, deletions, insertions, modifications):
                    let dataWall = results
                        .where { $0.id == self.friendsSelectedd.id }
                        .first!
                        .items
                    self.updateWallData(from: dataWall)
                    
                   print("Update RealmNews")
                case .error(let error):
                    print(error)
                }
              print("changet")
            
         }
        }catch {
            
        }
    }
    private func updateWallData(from data: List<UserWallItems>) {
        var wallData: [UserDetailsTableData] = []
           for item in data {
               var sectionData = DetailsSectionData()
               sectionData.id = item.id
               sectionData.ownerId = item.ownerId
               sectionData.date = item.date
               sectionData.textNews = item.text
               
               if let likes = item.likes {
                   sectionData.likes = likes
               }
               
               if let views = item.views {
                   sectionData.views = views
               }
               
               var typeSection: SectionType = .unknown
               
               if let attachments = item.attachments.first{
                   if let photo = attachments.photo {
                       typeSection = .SingleFoto
                       var likeStatus = false
                       if sectionData.likes.userLike == 1 {
                         likeStatus = true
                       }
                       
                       let size = getPhotoUrl(photo.sizes)
                       let photos = ImageAndLikeData(image: size.url, likeStatus: likeStatus, height:CGFloat(size.height), width: CGFloat(size.width), seenCount: sectionData.views?.count ?? 0)
                       sectionData.photo = [photos]
                       sectionData.urlNewsImage = size.url
                     
                   }else if let link = attachments.link {
                       if let photo = link.photo {
                           typeSection = .linkPhoto
                           
                           sectionData.urlNewsImage = getPhotoUrl(photo.sizes).url
                       }else {
                           typeSection = .link
                       }
                       
                       sectionData.linkUrl = link.url
                       sectionData.captionNews = link.caption
                       sectionData.titleNews = link.title
                       
                   }
               }else if let attachments = item.wallcopyHystory.first?.attachments {
                   for attachData in attachments {
                       if let photo = attachData.photo {
                           typeSection = .SingleFoto
                           let size = getPhotoUrl(photo.sizes)
                           sectionData.urlNewsImage = size.url
                           var likeStatus = false
                           if sectionData.likes.userLike == 1 {
                             likeStatus = true
                           }
                           let photos = ImageAndLikeData(image: size.url, likeStatus: likeStatus, height:CGFloat(size.height), width: CGFloat(size.width), seenCount: sectionData.views?.count ?? 0)
                           sectionData.photo = [photos]
                           
                       }else if let link = attachData.link {
                           if let photo = link.photo {
                               typeSection = .linkPhoto
                               sectionData.urlNewsImage = getPhotoUrl(photo.sizes).url
                           }else {
                               typeSection = .link
                           }
                           sectionData.linkUrl = link.url
                           sectionData.captionNews = link.caption
                           sectionData.titleNews = link.title
                           
                       }
                       
                   }
            
               }
               let data = UserDetailsTableData(sectionType: typeSection, sectionData: sectionData)
               wallData.append(data)
               
       }
        var friendData: UserDetailsTableData!
        var photoData: UserDetailsTableData!
        if self.dataTable != nil {
            
            if let friendsIndex = self.dataTable.firstIndex(where: { $0.sectionType == .Friends }) {
                friendData = self.dataTable[friendsIndex]
            }
            if let photoIndex = self.dataTable.firstIndex(where: { $0.sectionType == .Gallary }) {
                photoData = self.dataTable[photoIndex]
            }
        }
        self.dataTable = wallData
        if photoData != nil {
            self.dataTable.insert(photoData, at: 0)
        }
          
        if friendData != nil {
            self.dataTable.insert(friendData, at: 0)
        }
    }
}

extension DetailUserTableViewController {
    
    func loadUserWallFromRealm(from userId: Int ) async -> List<UserWallItems>? {
        var wallItems: List<UserWallItems>?
        do {
            let realm = try await Realm()
            realm.objects(UserWallResponse.self)
                .where{ $0.id == userId}
                .forEach { wall in
                    wallItems = wall.items
                }
            return wallItems
        }catch {
            print(error)
        }
        return nil
    }
}
