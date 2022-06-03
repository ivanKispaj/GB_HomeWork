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
    
    //MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
              //   После теста заменить id пользователя на id NetworkSessionData.shared.userId!
    
    func loadMyFriends() {
        
        let queueDefault = DispatchQueue.global(qos: .default)
        
        queueDefault.async {
                InternetConnections(host: "api.vk.com", path: "/method/friends.get").loadFriends(for: String(NetworkSessionData.shared.testUser), count: "")
            }
        
    }
    
     func setNotificationtoken() {
        if let data = self.realmService.readData(FriendsResponse.self) {
            self.notifiToken = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("FriendsController Signed ")
                case let .update(results, _, _, _):
                    if let response = results.where({ $0.id == NetworkSessionData.shared.testUser }).first {
                        if response.countFriends != self.friendsArray.count {
                            let operationParseFriend = OperationParseDataFromRealm()
                            let operationSetViewData = OperationFriendViewData(setView: self)
                            operationSetViewData.addDependency(operationParseFriend)
                            self.queue.addOperation(operationParseFriend)
                            OperationQueue.main.addOperation(operationSetViewData)
                        }
                    }
                    
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
 
}


