//
//  LoadUserGroupFromVK.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//72287677

import UIKit
import RealmSwift

extension UserGroupTableViewController {
    
    func loadUserGroupFromVK()  {

        if let userId = NetworkSessionData.shared.userId {
            InternetConnections(host: "api.vk.com", path: "/method/groups.get").getUserGroupList(for: String(userId))
        }
        
        let groupsData = self.realmService.readData(ItemsGroup.self)
        if let data = groupsData {
            self.updateViewGroups(from: data)
        }
        
    }
    
    
     func updateViewGroups(from data: Results<ItemsGroup> ){
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
    
    
     func setNitificationGroups() {
        if let data = self.realmService.readData(ItemsGroup.self) {
            self.nitifiTokenGroups = data.observe { (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("Signed")
                case let .update(results, deletions, insertions, _):
                    if deletions.count != 0 || insertions.count != 0 {
                    self.updateViewGroups(from: results)
                    }
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
}


