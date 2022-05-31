//
//  LoadMyFriends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//
// 387485849
import UIKit
import RealmSwift

extension FriendsTableViewController {
  
    func loadMyFriends() {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
          //   После теста заменить id пользователя на id NetworkSessionData.shared.userId!
     
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(NetworkSessionData.shared.testUser))
        }
        
        
        if let friendsData = self.realmService.readData(FriendsResponse.self)!.where({ $0.id == NetworkSessionData.shared.testUser }).first{
           
            updateFriendsView(From: friendsData)
        }

    }
    
     func setNotificationtoken() {
        if let data = self.realmService.readData(FriendsResponse.self) {
            self.notifiToken = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("FriendsController Signed ")
                case let .update(results, deletions, insertions, _):
                    if deletions.count != 0 || insertions.count != 0 {
                  //      let a = results.where({ $0.id == NetworkSessionData.shared.testUser }).first!
                            self.updateFriendsView(From: results.where({ $0.id == NetworkSessionData.shared.testUser }).first!)
                    }
          
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
  
    private func updateFriendsView(From response: FriendsResponse) {
        var arrays = [Friend]()
        let items = response.items
        for friendData in items {
            let friends = Friend()
            friends.countFriends = response.countFriends
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

            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            arrays.append(friends)
        }
        self.friendsArray = arrays
    }
}


