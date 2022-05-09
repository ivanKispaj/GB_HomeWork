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

    func loadPhotoAlbumSelctedUser (_ friends: [Friend])  async -> [ImageAndLikeData]? {
        do {
            try await InternetConnections(host: "api.vk.com", path: "/method/photos.getAll").LoadPhotoUser(for: String(self.friendsSelectedd.id))
            
            if let photoData = await loadFriendsPhotoFromRealm(from: self.friendsSelectedd.id) {
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
            return imageArray
            }
            
        }catch {
            print(error)
        }
        return nil
    }
}

extension DetailUserTableViewController {
    func loadFriendsPhotoFromRealm(from userId: Int ) async -> List<PhotoItems>?{
        var photoItems: List<PhotoItems>?
        do {
            let realm = try await Realm()
            realm.objects(PhotoResponse.self)
                .where{ $0.id == userId}
                .forEach{ photos in
                    photoItems = photos.items
                }
            return photoItems
        }catch {
            print(error)
        }
        return nil
    }
}
