//
//  RealmService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 10.05.2022.
//

import RealmSwift

final class RealmService {
    
    func deliteData<T: Object> (_ object: T) {
        do {
            let realm = try Realm()
            try! realm.write{
                realm.delete(object)
            }
            
        }catch {
           print(error)
        }
    }
    
    func updateData<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        }catch {
            print(error)
        }
    }
    
    func updateData<T: Object>(_ object: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        }catch {
            print(error)
        }
    }
    
    func saveData<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
           
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        }catch {
            print(error)
        }
    }
    
    
    
    func readData<T: Object>(_ object: T.Type) -> Results<T>? {
        do {
            let realm = try Realm()
            return realm.objects(object)
        }catch {
            print("Error readData from RealmBase")
        }
        return nil
    }
    
}
