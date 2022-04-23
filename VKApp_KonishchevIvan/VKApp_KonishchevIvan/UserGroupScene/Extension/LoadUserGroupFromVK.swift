//
//  LoadUserGroupFromVK.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

extension UserGroupTableViewController {
    
    func loadUserGroupFromVK() {
        InternetConnections(host: "api.vk.com", path: "/method/groups.get").getUserGroupList(for: "72287677") { [weak self] response in
            switch response {
                
            case .success(let result):
                var group: [AllUserGroups] = []
                for items in result.response.items {
                    let res = AllUserGroups(nameGroup: items.groupName, logoGroup: items.photoGroup)
                    group.append(res)
                }
                self?.myActiveGroup = group
            case .failure(_):
                print("ErrorLoadUserGroupFromVK")
            }
        }
    }
}
