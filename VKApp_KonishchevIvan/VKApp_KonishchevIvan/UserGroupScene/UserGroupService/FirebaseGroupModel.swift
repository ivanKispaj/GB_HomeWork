//
//  FirebaseGroupModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.05.2022.
//

import Foundation
import FirebaseDatabase

final class FirebaseGroupModel {
    let groupId: Int
    let groupName: String
    let ref: DatabaseReference?
    init(groupId: Int, groupName: String){
        self.ref = nil
        self.groupId = groupId
        self.groupName = groupName
    }
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String: Any],
            let groupId = value["groupId"] as? Int,
            let groupName = value["groupName"] as? String
        else {
                return nil
            }
        self.ref = snapshot.ref
        self.groupId = groupId
        self.groupName = groupName
    }
    func toAnyObject() -> [String: Any] {
        ["groupId": groupId, "groupName": groupName]
    }
}
