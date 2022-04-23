//
//  LoadMyFriends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//

import UIKit

extension FriendsTableViewController {
  
    func loadMyFriends() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
      InternetConnections(host: "api.vk.com", path: "/method/friends.get").getListOfFirends(for: "72287677") { [weak self] response in
          switch response {
// обработка ответа
          case .success(let result):
              var friends: [FriendArray] = []
              for arrayFriends in result.response.items {
                  var online: Bool?
                  var isBanned: Bool?
                  if arrayFriends.online == 0 {
                      online = false
                  }else {
                      online = true
                  }
                  if arrayFriends.banned != nil {
                      isBanned = true
                  }else {
                      isBanned = false
                  }
                  var cityName: String = "unknown"
                  if arrayFriends.city != nil {
                      cityName = arrayFriends.city!.title
                  }
                  var lastSeenData: Double = 0
                  if arrayFriends.lastSeen != nil {
                      lastSeenData = arrayFriends.lastSeen!.time
                  }

                  let name = (arrayFriends.fName) + " " + (arrayFriends.lName)
                  let friend = FriendArray(userName: name, photo: arrayFriends.photo50, id: arrayFriends.id, city: cityName, lastSeenDate: lastSeenData, isClosedProfile: arrayFriends.isClosedProfile ?? false, isBanned: isBanned!, online: online!)
                  friends.append(friend)
                  DispatchQueue.main.async {
                      self!.activityIndicator.isHidden = true
                      self!.activityIndicator.stopAnimating()
                  }
          
              }
              self?.friendsArray = friends
          case .failure(_):
              print("ErrorLoadDataVK")
          }
      }
    }
}
