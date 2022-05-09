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

    func LoadUserWall (_ friends: [Friend], photos: [ImageAndLikeData]) async {
        
        var userDetailsTableData: [UserDetailsTableData]! {
            didSet {
                return finishLoadData( friends: friends, photos: photos, wall: userDetailsTableData)
            }
        }
        
        do {
            try await InternetConnections(host: "api.vk.com", path: "/method/wall.get").getUserWall(for: String(self.friendsSelectedd.id))

            if let items = await self.loadUserWall(from: self.friendsSelectedd.id) {
                var detailsTableData: [UserDetailsTableData] = []
                
                for item in items {
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
                    detailsTableData.append(data)
                }
                userDetailsTableData = detailsTableData
            }
            
            
        }catch {
            print(error)
        }

    }

    private func finishLoadData( friends: [Friend], photos: [ImageAndLikeData], wall: [UserDetailsTableData]) {
              var details = wall
                    details.insert(UserDetailsTableData(sectionType: .Gallary, sectionData: DetailsSectionData(photo: photos)), at: 0)
                    details.insert(UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData(friends: friends)), at: 0)
                    self.dataTable = details
            

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
    
}

extension DetailUserTableViewController {
    
    func loadUserWall(from userId: Int ) async -> List<UserWallItems>? {
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
