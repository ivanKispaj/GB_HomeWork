//
//  LoadAndSaveFriends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//

import UIKit
import RealmSwift

//MARK: - Загрузка друзей!
extension InternetConnections {
    func loadFriends(for userId: String)  {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "fields", value: "photo_50, city, last_seen, online, status "),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "20")
        ]
        guard let url = self.urlComponents.url else { return }
    
        self.session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(InternetError.requestError(error))
        }
            guard let data = data else {
                return
            }
            do {
                let decode = JSONDecoder()
                // передаем пользователя для связи списка друзей с ним один ко многим!
                        decode.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(userId)!]
                        let result = try decode.decode(Friends.self, from: data )
                // Записываем друзей для переданного пользователя в Realm!
                DispatchQueue.main.async {
                    self.saveFriends(result, to: Int(userId)!)
                }
            }catch {
                print(InternetError.parseError)
            }
        }.resume()
             
       

       
    }
    
//MARK: - Запись друзей в RealmSwift
    private func saveFriends(_ friends: Friends, to ownerId: Int) {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL!)
            
                try realm.write {
                    realm.add(friends.response, update: .modified)
                }
            
          
        }catch {
            print("Error Save Realm: \(error.localizedDescription)")
        }
         
    }
}
