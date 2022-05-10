//
//  LoadUserGroupFromVK.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//72287677

import UIKit
import RealmSwift

extension UserGroupTableViewController {
    
    func loadUserGroupFromVK() async {

        InternetConnections(host: "api.vk.com", path: "/method/groups.get").getUserGroupList(for: String(NetworkSessionData.shared.userId!))
        self.setNitificationGroups()
        if let result = await loadUserGroups() {
            self.updateViewGroups(from: result)
        }
        
    }
    
    
    private func updateViewGroups(from data: Results<ItemsGroup> ){
        var group: [AllUserGroups] = []
        for items in data {
            if let activity = items.activity {
            let res = AllUserGroups(nameGroup: items.groupName, logoGroup: items.photoGroup, activity: activity)
                group.append(res)
            }else {
                let res = AllUserGroups(nameGroup: items.groupName, logoGroup: items.photoGroup, activity: "")
                    group.append(res)
            }
        }
        self.myActiveGroup = group
    }
    
    private func setNitificationGroups() {
            do {
                let realm = try Realm()
                let data = realm.objects(ItemsGroup.self)
                self.nitifiTokenGroups = data.observe { (changes: RealmCollectionChange) in
                    switch changes {
                    case .initial( let results ):
                        print("Initial NewsRealm")
                    case let .update(results, deletions, insertions, modifications):
                        self.updateViewGroups(from: results)
                       print("Update RealmNews")
                    case .error(let error):
                        print(error)
                    }
                  print("changet")
                
             }
            }catch {
                print("error Notification Set!")
            }
        
    }
}



private extension UserGroupTableViewController {
    
    func loadUserGroups () async -> Results<ItemsGroup>? {
        do {
            let realm = try await Realm()
            let itemGroups = realm.objects(ItemsGroup.self)
            return itemGroups
        }catch {
            print(error)
        }
        
            return nil
    }
}
