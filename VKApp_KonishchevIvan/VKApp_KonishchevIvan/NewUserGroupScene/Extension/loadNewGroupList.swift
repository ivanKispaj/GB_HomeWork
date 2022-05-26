//
//  LoadNewGroupList.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
extension NewGroupTableViewController {
    func LoadNewGroupList(searchText text: String) {
        InternetConnections(host: "api.vk.com", path: "/method/groups.search").getNewGroupList(for: text) { response in
            switch response {
            
            case .success(let result): 
                var group: [AllNewUserGroups] = []
                for items in result.response.items {
                if let activity = items.activity {
                 
                    
                    let res = AllNewUserGroups(id: items.id, nameGroup: items.groupName, logoGroup: items.photoGroup, activity: activity)
                        group.append(res)
                }else {
                    let res = AllNewUserGroups(id: items.id, nameGroup: items.groupName, logoGroup: items.photoGroup, activity: "")
                        group.append(res)
                }

                }
                self.allGroups = group
                case .failure(_):
                    print("ErrorLoadUserGroupFromVK")
            }
        }
    }
}
