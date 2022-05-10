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
  
    func loadFriendsSelectedUser() async {
  
        var userDetailsTableData: UserDetailsTableData!
        
            InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(self.friendsSelectedd.id))

            if let friendsArray = await loadFriendsFromRealm(from: self.friendsSelectedd.id) {
                var arrays = [Friend]()
                for friendData in friendsArray {
                    let friends = Friend()
                    
                    if friendData.online == 1 {
                        friends.online = true
                    }
                    
                    if friendData.banned != nil {
                        friends.isBanned = true
                    }
                    
                    if friendData.city != nil {
                        friends.city = friendData.city!.title
                    }else {
                        friends.city = "unknown"
                    }
                    
                    if friendData.lastSeen != nil {
                        friends.lastSeenDate = friendData.lastSeen!.time
                    }

                    if  let status = friendData.status {
                        friends.status = status
                    }
                    
                    let name = (friendData.fName) + " " + (friendData.lName)
                    friends.userName = name
                    friends.id = friendData.id
                    friends.photo = friendData.photo50
                    friends.isClosedProfile = friendData.isClosedProfile

                    arrays.append(friends)
                }
                userDetailsTableData = UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData(friends: arrays))
                if self.dataTable != nil {
                    self.dataTable.append(userDetailsTableData)
                }else {
                    self.dataTable = [userDetailsTableData]
                }
               
               // return arrays
            }
               // return nil
    }
}



extension DetailUserTableViewController {
    func loadFriendsFromRealm(from userId: Int ) async -> List<FriendsItems>?{
        var friends: List<FriendsItems>?
        do {
            let realm = try await Realm()
            realm.objects(FriendsResponse.self)
                .where{ $0.id == userId}
                .forEach{friend in
                    friends = friend.items
                }
            return friends
        }catch {
            print(error)
        }
        return nil
    }
}
