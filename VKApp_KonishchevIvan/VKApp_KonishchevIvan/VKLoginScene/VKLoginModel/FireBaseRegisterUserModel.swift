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
    let id: Int
    let ref: DatabaseReference?
    
    init(id: Int) {
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
    guard
    let value = snapshot.value as? [String: Any],
    let id = value["userId"] as? Int else {
    return nil
    }
    self.ref = snapshot.ref
    self.id = id
    }
    func toAnyObject() -> [String: Any] {
    ["userId": id,]
    
    }
    
}
