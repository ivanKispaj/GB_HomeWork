//
//  issetGroup.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 06.03.2022.
//

import UIKit

//MARK: - Extension NewGroupTableViewController

extension NewGroupTableViewController {
     func issetGroup(_ groupe: AllUserGroups, groupArray: [AllUserGroups]) -> Int? {
        guard let index = groupArray.firstIndex(of: groupe) else { return nil}
        return index
    }
}
