//
//  LoadUserGroupFromVK.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//72287677

import UIKit
import RealmSwift
import FirebaseDatabase

extension UserGroupTableViewController {
    
    
    func loadUserGroupFromVK()  {

        if let userId = NetworkSessionData.shared.userId {
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/groups.get").getUserGroupList(for: String(userId))
            }
        }
        
        let groupsData = self.realmService.readData(ItemsGroup.self)
        if let data = groupsData {
            self.updateViewGroups(from: data)
        }
        
    }
    
    
     func updateViewGroups(from data: Results<ItemsGroup> ){
        var group: [AllUserGroups] = []
         guard let userId = NetworkSessionData.shared.userId else { return }

         
         
        for items in data {
            
         // Запись групп и пользователя в Firebase
            let referense = self.ref.child(String(userId)).child("userGroup").child(String(items.id)) // id group
            let groupData = FirebaseGroupModel(groupId: items.id, groupName: items.groupName)
            referense.setValue(groupData.toAnyObject())
            
            if let activity = items.activity {
                let res = AllUserGroups(id: items.id,nameGroup: items.groupName, logoGroup: items.photoGroup, activity: activity)
                group.append(res)
            }else {
                let res = AllUserGroups(id: items.id,nameGroup: items.groupName, logoGroup: items.photoGroup, activity: "")
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


