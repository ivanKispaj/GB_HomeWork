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
      InternetConnections(host: "api.vk.com", path: "/method/friends.get").getListOfFirends(for: "72287677") { [weak self] response in
          switch response {
// обработка ответа
          case .success(let result):
              
              let friendArray = FriendArray()
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

                  DispatchQueue.main.async {
                      self?.saveFriendsData(newsData: friendArray)
                      self!.activityIndicator.isHidden = true
                      self!.activityIndicator.stopAnimating()
                  }
                  friendArray.friendArray.append(friends)
          
                  arrays.append(friends)
              }
              
               self?.friendsArray = arrays
          case .failure(_):
              print("ErrorLoadDataVK")
          }
      }
    }
}


// MARK: - Private
private extension FriendsTableViewController {
    func saveFriendsData(newsData: FriendArray)  {
         let realmDB = try!  Realm()
      //  print(realmDB.configuration.fileURL!)
            do {
                    realmDB.beginWrite()
                    realmDB.add(newsData)
               try  realmDB.commitWrite()
                
            } catch let error as NSError {
                print("Something went wrong: \(error.localizedDescription)")
            }
    }
}
