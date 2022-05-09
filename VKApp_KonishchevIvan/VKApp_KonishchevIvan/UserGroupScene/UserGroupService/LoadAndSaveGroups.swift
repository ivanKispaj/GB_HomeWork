//
//  LoadAndSaveGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//

import UIKit
import RealmSwift

//MARK: - метод для запроса групп пользователя
extension InternetConnections {
    func getUserGroupList(for user_id: String) async throws {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity, city, description, links, site, status "),
            URLQueryItem(name: "v", value: "5.131"),
           // URLQueryItem(name: "count", value: "3")
        ]
        guard let url = self.urlComponents.url else { throw InternetError.parseError }
 
        
            do {
                let (data, _ ) = try await self.session.data(from: url)
                let decode = JSONDecoder()
                let result = try decode.decode(UserGroupModel.self, from: data)
                await self.saveUserGroups(result)
            }catch {
                throw InternetError.parseError
            }
       
    }
    
    //MARK: - Save Wall Data To Realm
        private func saveUserGroups(_ groupsData:  UserGroupModel ) async {
            if let realm = try? await Realm() {
                   do {
                           try realm.write{
                               realm.add(groupsData.response.items, update: .modified)
                           }
                       
                   } catch let error as NSError {
                       print("Something went wrong: \(error.localizedDescription)")
                   }
            }
        }
}




