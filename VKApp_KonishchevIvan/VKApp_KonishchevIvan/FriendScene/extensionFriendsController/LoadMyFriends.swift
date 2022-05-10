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
  
    func loadMyFriends() async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
        
      
            
            //   После теста заменить id пользователя на id NetworkSessionData.shared.userId!
        self.setNotificationtoken()
        InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: "72287677")
     
            if let friendsArray = loadFriendsFromRealm() {

                updateFriendsView(From: friendsArray)
            
            }

    }
    
    private func setNotificationtoken() {
        do {
            let realm = try Realm()
            let data = realm.objects(FriendsResponse.self)
            self.notifiToken = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial( let results ):
                    print("Initial NewsRealm")
                case let .update(results, deletions, insertions, modifications):
                    self.updateFriendsView(From: results.first!.items)
                   print("Update RealmNews")
                case .error(let error):
                    print(error)
                }
              print("changet")
            
         }
        }catch {
            
        }
    }
    
    private func updateFriendsView(From items: List<FriendsItems> ) {
        var arrays = [Friend]()
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

            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            arrays.append(friends)
        }
        self.friendsArray = arrays
    }
}

extension FriendsTableViewController {
    
    func loadFriendsFromRealm()  -> List<FriendsItems>?{
        var friends: List<FriendsItems>?
        do {
            
            let realm = try Realm()
            realm.objects(FriendsResponse.self)
//   После теста заменить id пользователя на let id = NetworkSessionData.shared.userId!
                .where{ $0.id == 72287677}
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
