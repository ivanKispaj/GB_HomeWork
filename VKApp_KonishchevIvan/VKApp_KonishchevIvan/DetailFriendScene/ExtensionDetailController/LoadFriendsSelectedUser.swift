//
//  LoadImageView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

// MARK: - Подгружаем друзей друга и сохраняем результат в hisFriends
extension DetailUserTableViewController {
  
    func loadFriendsSelectedUser() {
  
        var hisFriends: [Friend]!{
            didSet {
                self.loadPhotoAlbumSelctedUser( hisFriends )
            }
        }
        
        InternetConnections(host: "api.vk.com", path: "/method/friends.get").getListOfFirends(for: String(self.friendsSelectedd.id)) { [ weak self ]request in
            switch request {
                case .success(let result):
                self!.saveSelectedUserFriends(result)
                
                var arrays = [Friend]()
                for arrayFriends in result.response.items {
                    let friends = Friend()
                  
                    if arrayFriends.online == 1 {
                        friends.online = true
                    }
                    if arrayFriends.banned != nil {
                        friends.isBanned = true
                    }
                    
                    if arrayFriends.city != nil {
                        friends.city = arrayFriends.city!.title
                    }else {
                        friends.city = "unknown"
                    }
                    
                    if arrayFriends.lastSeen != nil {
                        friends.lastSeenDate = arrayFriends.lastSeen!.time
                    }
                   
                    if  let status = arrayFriends.status {
                        friends.status = status
                    }

                    let name = (arrayFriends.fName) + " " + (arrayFriends.lName)
                    friends.userName = name
                    friends.id = arrayFriends.id
                    friends.photo = arrayFriends.photo50
                    friends.isClosedProfile = arrayFriends.isClosedProfile ?? false
                    arrays.append(friends)
                }
                hisFriends = arrays
 
                case .failure(_):
                    print("Error request friends")
            }
        }
        
    }
}




private extension DetailUserTableViewController {
    
    func saveSelectedUserFriends(_ friends: Friends) {
        
                DispatchQueue.main.async {
                    let realmDB = try!  Realm()
        //           print(realmDB.configuration.fileURL!)
                       do {
                           try realmDB.write{
                               realmDB.add(friends.response.items, update: .modified)
                           }
                       } catch let error as NSError {
                           print("Something went wrong: \(error.localizedDescription)")
                       }
                }
    }
}
