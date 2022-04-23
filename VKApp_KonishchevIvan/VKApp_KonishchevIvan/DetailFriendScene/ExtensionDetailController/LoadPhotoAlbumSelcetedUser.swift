//
//  LoadPhotoAlbumSelcetedUser.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

//MARK: - Подгружаем фото выбранного друга

extension DetailUserTableViewController {
    
    func loadPhotoAlbumSelctedUser () {
        InternetConnections(host: "api.vk.com", path: "/method/photos.getAll").getPhotoUser(for: String(self.friendsSelectedd.id)) { request in
            switch request {
                case .success(let result):
                    var imageArray = [ImageAndLikeData]()
                    for photoArray in result.response.items {
                        var imageArr = ImageAndLikeData(image: "", likeStatus: false, likeLabel: 0)
                        imageArr.likeStatus = false
                        imageArr.likeLabel = photoArray.likes.count
                            for photo in photoArray.photo {
                                if photo.type == "y" {
                                    imageArr.image = photo.url
                                    imageArray.append(imageArr)
                                    break
                                }
                            }
                    }
                         
                    self.photo = imageArray
                    case .failure(_):
                        print("Error request Photo")
            }
        }
    }
}

