//
//  saveUserIdFirebase.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation
import FirebaseDatabase

extension VKLoginViewController {
    func saveUserIdFirebase(to userId: Int) {
        let saveFirebaseUser = FireBaseRegisterUserModel(id: userId)
        self.ref.setValue(saveFirebaseUser.toAnyObject())
    }
}
