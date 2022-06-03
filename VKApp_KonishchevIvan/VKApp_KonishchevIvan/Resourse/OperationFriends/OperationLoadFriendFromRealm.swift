//
//  OperationLoadFriendFromRealm.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.06.2022.
//

import Foundation
import RealmSwift

 final class OperationLoadFriendsFromRealm: Operation {
    private var realmService: RealmService
    private var friendId: Int
    private(set) var friendsResponse: FriendsResponse?
    
    init(friendId: Int) {
        self.realmService = RealmService()
        self.friendId = friendId
    }
    override func main() {
        self.friendsResponse = self.realmService.readData(FriendsResponse.self)!.where({ $0.id == self.friendId }).first
    }
}
