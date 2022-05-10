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
  
   
       
        InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(self.friendsSelectedd.id))
        self.setNotificationtokenFriends()
            if let friendsArray = await loadFriendsFromRealm(from: self.friendsSelectedd.id) {
                self.updateUserFromRealm(from: friendsArray)
            }
     
    }
    
    private func setNotificationtokenFriends() {
        do {
            let realm = try Realm()
            let data = realm.objects(FriendsResponse.self)
                .where { $0.id == self.friendsSelectedd.id}
            self.notifiTokenFriends = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial( let results ):
                    print("Initial NewsRealm")
                case let .update(results, deletions, insertions, modifications):
                    let dataFriends = results
                        .where { $0.id == self.friendsSelectedd.id }
                        .first!
                        .items
                    self.updateUserFromRealm(from: dataFriends)
                    
                   print("Update RealmNews")
                case .error(let error):
                    print(error)
                }
              print("changet")
            
         }
        }catch {
            
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

