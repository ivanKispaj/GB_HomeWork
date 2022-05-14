//
//  FireBaseRegisterUserModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation
import Firebase
import FirebaseDatabase

final class FireBaseRegisterUserModel {
    let userId: Int
    let groupId: Int?
    let groupName: String?
    let ref: DatabaseReference?
    init(userId: Int, groupId: Int?, groupName: String?){
        self.ref = nil
        self.userId = userId
        self.groupId = groupId
        self.groupName = groupName
    }
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String: Any],
            let userId = value["userId"] as? Int,
            let groupId = value["groupId"] as? Int,
            let groupName = value["groupName"] as? String else {
                return nil
            }
        self.ref = snapshot.ref
        self.userId = userId
        self.groupId = groupId
        self.groupName = groupName
    }
    func toAnyObject() -> [String: Any] {
        ["userId": userId,
         "groupId": groupId ?? 0,
         "groupName": groupName ?? ""]
    }
}
