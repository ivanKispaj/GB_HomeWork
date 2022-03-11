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
//        for nextArr in friendsAlphavite {
//            let char = nextArr.name.first!
//            let index = friends.firstIndex(where: {$0.header == String(char) })
//
//            if index == nil {
//                friends.append(DataSection(header: String(char), row: [nextArr]))
//                indexTitle.append(String(char))
//            }else {
//                friends[index!].row.append(nextArr)
//            }
//        }
    }
}

