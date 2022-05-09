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
    func loadFriends(for userId: String) async throws {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "fields", value: "photo_50, city, last_seen, online, status "),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "20")
        ]
        guard let url = self.urlComponents.url else { throw InternetError.parseError }
    
            do {
                let (data, _ ) = try await self.session.data(from: url)
                let decode = JSONDecoder()
        // передаем пользователя для связи списка друзей с ним один ко многим!
                decode.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(userId)!]
                let result = try decode.decode(Friends.self, from: data )
        // Записываем друзей для переданного пользователя в Realm!
                await self.saveFriends(result, to: Int(userId)!)
            }catch {
                throw InternetError.parseError
            }
       
    }
    
//MARK: - Запись друзей в RealmSwift
    private func saveFriends(_ friends: Friends, to ownerId: Int) async {
        if let realm = try? await Realm() {
            print(realm.configuration.fileURL!)
            do {
                try realm.write {
                    realm.add(friends.response, update: .modified)
                }
            }catch let error as NSError {
                print("Error Save Realm: \(error.localizedDescription)")
            }
        }

                
    }
}
