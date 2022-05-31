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
        let queueInteractive = DispatchQueue.global(qos: .userInteractive)
        let queueDefault = DispatchQueue.global(qos: .utility)
        let friendsData = self.realmService.readData(FriendsResponse.self)?.where{ $0.id == self.friendsSelected.id }.first
    
        if let data = friendsData {
            self.updateUserFromRealm(from: data)
       
                queueDefault.async {
                    InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(self.friendsSelected.id), count: "")
                }
            
        }else {
            queueInteractive.async {
            InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(self.friendsSelected.id))
            }
            queueDefault.async {
                InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(self.friendsSelected.id), count: "")
            }
        }
    }
    
     func setNotificationtokenFriends() {
        if let data = self.realmService.readData(FriendsResponse.self) {
            self.notifiTokenFriends = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("DetailVC UserFriends Signed")
                case let .update(results, _, _, _):
                    let dataFriends = results
                        .where { $0.id == self.friendsSelected.id }
                        .first
                        if let data = dataFriends {
                            self.updateUserFromRealm(from: data)

                        }
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
 
    
   private func updateUserFromRealm(from data: FriendsResponse) {
        var arrays = [Friend]()
       let items = data.items
        for friendData in items {
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
       let dataFriends = UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData( friends: arrays, friendsCount: data.countFriends))
        
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




