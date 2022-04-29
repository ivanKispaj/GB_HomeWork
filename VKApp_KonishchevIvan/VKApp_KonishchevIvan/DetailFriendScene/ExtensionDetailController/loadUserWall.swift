//
//  loadUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//

import UIKit

extension DetailUserTableViewController {

    func LoadUserWall (_ friends: [FriendArray], photos: [ImageAndLikeData]) {

        var userDetailsTableData: [UserDetailsTableData]! {
            didSet {
                return finishLoadData( friends: friends, photos: photos, wall: userDetailsTableData)
            }
        }
        
        InternetConnections(host: "api.vk.com", path: "/method/wall.get").getUserWall(for: String(self.friendsSelectedd.id)) { [weak self] request in
            switch request {
           
                case .success(let result):
                var detailsTableData: [UserDetailsTableData] = []

                var typeSection: SectionType?
                let items = result.response.items
                for item in items {
                    var id = 0
                    var linkUrl: String?
                    var ownerId = 0
                    var date = 0
                    var textNews = ""
                    var likes = WallLikes(count: 0, userLike: 0)
                    var views: WallViews? = nil
                    var urlNewsImage: [String]? = []
                    var titleNews: String? = nil
                    var caption: String? = nil
                    var photos: [ImageAndLikeData] = []
                    id = item.id
                    ownerId = item.ownerId
                    date = item.date
                    textNews = item.text
                    likes = item.likes!
                    if let itemViews = item.views {
                        views = itemViews
                    } else {
                        views = WallViews(count: 0)
                    }
                    if let attachment = item.attachments {
                      
                            if let photo = attachment[0].photo {
                                typeSection = .SingleFoto
                                let photoData = self!.getPhotoUrl(photo.sizes)
                                urlNewsImage?.append(photoData.url)
                                var likeStatus = false
                                if likes.userLike == 1 {
                                    likeStatus = true
                                }
                                let imageAndLikeData = ImageAndLikeData(image: photoData.url, likeStatus: likeStatus, height: CGFloat(photoData.height), width: CGFloat(photoData.width), seenCount: likes.count)
                                photos.append(imageAndLikeData)
                            }else if let link = attachment[0].link {
                                typeSection = .link
                                linkUrl = link.url
                                if let photo = link.photo  {
                                    let photoData = self!.getPhotoUrl(photo.sizes)
                                    urlNewsImage?.append(photoData.url)
                                    var likeStatus = false
                                    if likes.userLike == 1 {
                                        likeStatus = true
                                    }
                                    let imageAndLikeData = ImageAndLikeData(image: photoData.url, likeStatus: likeStatus, height: CGFloat(photoData.height), width: CGFloat(photoData.width), seenCount: likes.count)
                                    photos.append(imageAndLikeData)
                                }
                                caption = link.caption
                                titleNews = link.title
                                
                            }else {
                                typeSection = nil
                            }
                    } else if let copyHis = item.copyHystory, let attachments = copyHis[0].attachments {
                        if let photo = attachments[0].photo {
                            typeSection = .SingleFoto
                            let photoData = self!.getPhotoUrl(photo.sizes)
                            urlNewsImage?.append(photoData.url)
                            var likeStatus = false
                            if likes.userLike == 1 {
                                likeStatus = true
                            }
                            let imageAndLikeData = ImageAndLikeData(image: photoData.url, likeStatus: likeStatus, height: CGFloat(photoData.height), width: CGFloat(photoData.width), seenCount: likes.count)
                            photos.append(imageAndLikeData)
                        }else if let link = attachments[0].link {
                            typeSection = .link
                            linkUrl = link.url
                            if let photo = link.photo  {
                                let photoData = self!.getPhotoUrl(photo.sizes)
                                urlNewsImage?.append(photoData.url)
                                var likeStatus = false
                                if likes.userLike == 1 {
                                    likeStatus = true
                                }
                                let imageAndLikeData = ImageAndLikeData(image: photoData.url, likeStatus: likeStatus, height: CGFloat(photoData.height), width: CGFloat(photoData.width), seenCount: likes.count)
                                photos.append(imageAndLikeData)
                            }else {
                                typeSection = nil
                            }
                            caption = link.caption
                            titleNews = link.title
                            
                        }
                    }
                    if let type = typeSection {
                        let detailsSectionData = DetailsSectionData(id: id, ownerId: ownerId, date: date, textNews: textNews, likes: likes, views: views, urlNewsImage: urlNewsImage, titleNews: titleNews, captionNews: caption, link: linkUrl, photo: photos)
                        let data  = UserDetailsTableData( sectionType: type, sectionData: detailsSectionData)
                        detailsTableData.append(data)
                    }
                    typeSection = nil
                  
                }
                userDetailsTableData = detailsTableData
                    case .failure(_):
                        print("Error request Photo")
            }
        }
    }
    
    private func finishLoadData( friends: [FriendArray], photos: [ImageAndLikeData], wall: [UserDetailsTableData]) {
              var details = wall
                    details.insert(UserDetailsTableData(sectionType: .Gallary, sectionData: DetailsSectionData(photo: photos)), at: 0)
                    details.insert(UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData(friends: friends)), at: 0)
                    self.dataTable = details
            

    }
   private func getPhotoUrl(_ photoArr: [WallSizes]) -> WallSizes {
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
