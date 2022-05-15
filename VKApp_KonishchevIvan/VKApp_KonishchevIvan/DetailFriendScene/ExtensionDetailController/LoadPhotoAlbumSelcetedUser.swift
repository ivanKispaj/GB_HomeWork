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

    func loadPhotoAlbumSelctedUser ()  {
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
        InternetConnections(host: "api.vk.com", path: "/method/photos.getAll").LoadPhotoUser(for: String(self.friendsSelectedd.id))
        }
        
        setNotificationTokenPhoto()
      
            let photoData = self.realmService.readData(PhotoResponse.self)?.where { $0.id == self.friendsSelectedd.id }.first?.items
            if let data = photoData {
                self.updateUserPhotoData(from: data)
            
        }
        
    }
    
     func setNotificationTokenPhoto() {
        if let data = self.realmService.readData(PhotoResponse.self) {
            self.notifiTokenPhoto = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("DetailVC UserPhoto Signed")
                case let .update(results, deletions, insertions, _):
                    let dataPhoto = results
                        .where { $0.id == self.friendsSelectedd.id }
                        .first!
                        .items
                    if deletions.count != 0 || insertions.count != 0 {
                    self.updateUserPhotoData(from: dataPhoto)
                    }
                case .error(_):
                    print("Asd")
                }
            }
        }
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
        
        if self.dataTable == nil {
            self.dataTable = [userDetailsTableData]
        }else if let index = self.dataTable.firstIndex(where: { $0.sectionType == .Gallary }) {
            self.dataTable.remove(at: index)
            if self.dataTable.count >= 1 {
                self.dataTable.insert(userDetailsTableData, at: 1)
            }
        }else {
            self.dataTable.append(userDetailsTableData)
        } 
    }
}
