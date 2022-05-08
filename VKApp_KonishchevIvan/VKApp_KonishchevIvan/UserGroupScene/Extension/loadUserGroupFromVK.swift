//
//  LoadUserGroupFromVK.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//72287677

import UIKit
import RealmSwift

extension UserGroupTableViewController {
    
    func loadUserGroupFromVK() {
        InternetConnections(host: "api.vk.com", path: "/method/groups.get").getUserGroupList(for: String(NetworkSessionData.shared.userId!)) { [weak self] response in
            switch response {
                
            case .success(let result):
                
                self?.saveUserGroups(result.response)
                var group: [AllUserGroups] = []
                for items in result.response.items {
                    if let activity = items.activity {
                    let res = AllUserGroups(nameGroup: items.groupName, logoGroup: items.photoGroup, activity: activity)
                        group.append(res)
                    }else {
                        let res = AllUserGroups(nameGroup: items.groupName, logoGroup: items.photoGroup, activity: "")
                            group.append(res)
                    }
                }
                self?.myActiveGroup = group
            case .failure(_):
                print("ErrorLoadUserGroupFromVK")
            }
        }
    }
}


private extension UserGroupTableViewController {
    func saveUserGroups (_ groups: GroupResponse) {
        DispatchQueue.main.async {
                    let realmDB = try!  Realm()
          //         print(realmDB.configuration.fileURL!)
                       do {
                           try realmDB.write{
                               realmDB.add(groups.items, update: .modified)
                           }
                       } catch let error as NSError {
                           print("Something went wrong: \(error.localizedDescription)")
                       }
                }
    }
}
