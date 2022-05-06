//
//  LoadImageView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

// MARK: - Подгружаем друзей друга и сохраняем результат в hisFriends
extension DetailUserTableViewController {
  
    func loadFriendsSelectedUser() {
  
//        var hisFriends: [Friend]!{
//            didSet {
//                self.loadPhotoAlbumSelctedUser( hisFriends )
//            }
//        }
//        
//        InternetConnections(host: "api.vk.com", path: "/method/friends.get").getListOfFirends(for: String(self.friendsSelectedd.id)) { request in
//            switch request {
//                case .success(let result):
//                var friends: [Friend] = []
//                for arrayFriends in result.response.items {
//                    var online: Bool?
//                    var isBanned: Bool?
//                    if arrayFriends.online == 0 {
//                        online = false
//                    }else {
//                        online = true
//                    }
//                    if arrayFriends.banned != nil {
//                        isBanned = true
//                    }else {
//                        isBanned = false
//                    }
//                    var cityName: String = "unknown"
//                    if arrayFriends.city != nil {
//                        cityName = arrayFriends.city!.title
//                    }
//                    var lastSeenData: Double = 0
//                    if arrayFriends.lastSeen != nil {
//                        lastSeenData = arrayFriends.lastSeen!.time
//                    }
//                    var statusText: String!
//                    if arrayFriends.status != nil {
//                        statusText = arrayFriends.status
//                    }else {
//                        statusText = " "
//                    }
//
//                    let name = (arrayFriends.fName) + " " + (arrayFriends.lName)
//                    let friend = Friend(userName: name, photo: arrayFriends.photo50, id: arrayFriends.id, city: cityName, lastSeenDate: lastSeenData, isClosedProfile: arrayFriends.isClosedProfile ?? false, isBanned: isBanned!, online: online!, status: statusText)
//                    friends.append(friend)
//                    
//                }
//                hisFriends = friends
// 
//                case .failure(_):
//                    print("Error request friends")
//            }
//        }
        
    }
}
