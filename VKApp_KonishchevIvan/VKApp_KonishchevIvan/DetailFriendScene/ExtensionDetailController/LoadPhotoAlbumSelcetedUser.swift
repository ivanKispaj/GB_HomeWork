//
//  LoadPhotoAlbumSelcetedUser.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

//MARK: - Подгружаем фото выбранного друга

extension DetailUserTableViewController {

    func loadPhotoAlbumSelctedUser ()  async  {
        
            InternetConnections(host: "api.vk.com", path: "/method/photos.getAll").LoadPhotoUser(for: String(self.friendsSelectedd.id))
        if let photoData = await loadFriendsPhotoFromRealm(from: self.friendsSelectedd.id) {

        }
        
    }
}

extension DetailUserTableViewController {
    func loadFriendsPhotoFromRealm(from userId: Int ) async -> List<PhotoItems>?{
       // var photoItems: List<PhotoItems>?
        do {
            let realm = try await Realm()
            let photosItem = realm.objects(PhotoResponse.self)
                .where{ $0.id == userId}
                .first
            if let resalt = photosItem?.items {
                self.notifiToken = resalt.observe { (changes: RealmCollectionChange) in
                    switch changes {
                    case .initial(let results):
                        print(results)
                    case let .update(results, deletions, insertions, modifications):
                    
                        self.updateUserPhotoData(from: results)
                        print(results)
                       print("Update RealmPhotos")
                    case .error(let error):
                        print(error)
                    }
                  print("changet")
                }
                return resalt
            }
            
        }catch {
            print(error)
        }
        return nil
    }
}

extension DetailUserTableViewController {
    
    func updateUserPhotoData(from photoData: List<PhotoItems>)  {
        
            var imageArray = [ImageAndLikeData]()
            
            for photoArray in photoData {
                var imageArr = ImageAndLikeData(image: "", likeStatus: false, likeLabel: 0, height: 0, width: 0,seenCount: 0)
                imageArr.likeStatus = false
                imageArr.likeLabel = photoArray.likes!.count
                    for photo in photoArray.photo {
                        if photo.type == "y" {
                            imageArr.image = photo.url
                            imageArr.height = CGFloat(photo.height)
                            imageArr.width = CGFloat(photo.width)
                            imageArray.append(imageArr)
                            break
                        }
                    }
            }
            let userDetailsTableData = UserDetailsTableData(sectionType: .Gallary, sectionData: DetailsSectionData(photo: imageArray))
            if self.dataTable != nil{
                self.dataTable.append(userDetailsTableData)
            }else {
                self.dataTable = [userDetailsTableData]
            }
  
    }
}
