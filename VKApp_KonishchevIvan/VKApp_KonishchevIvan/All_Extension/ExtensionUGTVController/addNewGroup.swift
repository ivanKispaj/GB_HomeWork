//
//  addNewGroup.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 06.03.2022.
//

import UIKit

//MARK: - Extension Controllers

extension UserGroupTableViewController: UserGroupTableViewDelegate {
    func addNewGroup(_ group: [AllUserGroups], allGroup: [AllUserGroups]) {
        self.myActiveGroup = group
        self.allGroup = allGroup
        tableView.reloadData()
       
    }
}
