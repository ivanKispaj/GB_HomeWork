//
//  RealmService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 10.05.2022.
//

import RealmSwift

final class RealmService {
  
// удаление объекта из базы
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
// Обновление данных в базе
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

// Обновление данных в базе массивом
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
 
// Запись данных в базу
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
    
    
 // чтение данных из базы
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
