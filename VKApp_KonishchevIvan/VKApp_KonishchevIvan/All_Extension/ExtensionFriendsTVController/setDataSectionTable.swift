//
//  setDataSectionTable.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 06.03.2022.
//

import UIKit

//MARK: - Extension FriendsTableViewController

extension FriendsTableViewController {
    
    
    
    func setDataSectionTable() {
        self.friends.append(posibleFriends)
        self.friends.append(DataSection(header: "Мои друзья", row: friendsAlphavite))
    }
}

