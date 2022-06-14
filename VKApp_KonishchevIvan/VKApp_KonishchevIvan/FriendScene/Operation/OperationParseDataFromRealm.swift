//
//  OperationParseDataFromRealm.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.06.2022.
//

import Foundation


final class OperationParseDataFromRealm: Operation {
    
    var friendsData: [Friend]?

    override func main() {
        guard let realmData = dependencies.first as? OperationLoadFriendsFromRealm else {
            print("Data not parsed")
            return
        }
        
        guard let response = realmData.friendsResponse else {
            print("Error load Data From Realm")
            return
        }
        DispatchQueue.global().async {
            self.parseData(from: response)
        }
       
    }
    
    
   private func parseData(from response: FriendsResponse) {
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
        arrays.append(friends)
    }
       self.friendsData = arrays
    }
}
