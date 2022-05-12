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
  
    func loadFriendsSelectedUser()  {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
        InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(self.friendsSelectedd.id))
        }
        
        let friendsData = self.realmService.readData(FriendsResponse.self)?.where{ $0.id == self.friendsSelectedd.id }.first?.items
        
        if let data = friendsData {
            self.updateUserFromRealm(from: data)
            
        }
    }
    
     func setNotificationtokenFriends() {
        if let data = self.realmService.readData(FriendsResponse.self) {
            self.notifiTokenFriends = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("Signed")
                case let .update(results, deletions, insertions, _):
                    let dataFriends = results
                        .where { $0.id == self.friendsSelectedd.id }
                        .first!
                        .items
                    if deletions.count != 0 || insertions.count != 0 {
                    self.updateUserFromRealm(from: dataFriends)
                    }
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
 
    
   private func updateUserFromRealm(from data: List<FriendsItems>) {
        var arrays = [Friend]()
        for friendData in data {
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
        let dataFriends = UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData(friends: arrays))
        
        if self.dataTable == nil {
            self.dataTable = [dataFriends]
        }else if let index = self.dataTable.firstIndex(where: { $0.sectionType == .Friends }){
            self.dataTable.remove(at: index)
            self.dataTable.insert(dataFriends, at: 0)
        }else {
            self.dataTable.insert(dataFriends, at: 0)
        }
    }
}




