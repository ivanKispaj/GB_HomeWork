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

        if let result = await loadUserGroups() {
            var group: [AllUserGroups] = []
            for items in result {
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
