//
//  LoadUserGroupFromVK.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//72287677

//import UIKit
//import RealmSwift
//import PromiseKit
//
//
//extension UserGroupTableViewController {
//    
//    
//    func loadUserGroupFromVK()  {
//        let groupsData = self.realmService.readData(ItemsGroup.self)
//        if let data = groupsData {
//          //  self.dataGroups = data
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        
//        if let userId = NetworkSessionData.shared.userId {
//            let queue = DispatchQueue.global(qos: .utility)
//            queue.async {
//            InternetConnections(host: "api.vk.com", path: "/method/groups.get").getUserGroupList(for: String(userId))
//            }
//        }
//        
//    }
//    
//    
//     func setNitificationGroups() {
//        if let data = self.realmService.readData(ItemsGroup.self) {
//            self.nitifiTokenGroups = data.observe { [weak self ] (changes: RealmCollectionChange) in
//                switch changes {
//                case .initial(_):
//                    print("UserGroup Signed")
//                case let .update(results, deletions, insertions, _):
//                    if deletions.count != 0 || insertions.count != 0 {
//               //         self!.dataGroups = results
//                        DispatchQueue.main.async {
//                            self!.tableView.reloadData()
//                        }
//                    }
//                case .error(_):
//                    print("Asd")
//                }
//            }
//        }
//    }
//
//    
//    
//}


