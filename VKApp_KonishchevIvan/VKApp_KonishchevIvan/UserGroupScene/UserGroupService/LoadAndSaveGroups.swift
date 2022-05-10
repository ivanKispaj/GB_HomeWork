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
    func getUserGroupList(for user_id: String) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity, city, description, links, site, status "),
            URLQueryItem(name: "v", value: "5.131"),
           // URLQueryItem(name: "count", value: "3")
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
                let result = try decode.decode(UserGroupModel.self, from: data)
                DispatchQueue.main.async {
                    self.saveUserGroups(result)
                }
                
            }catch {
                print(InternetError.parseError)

            }
        }.resume()
    }
    
    //MARK: - Save Wall Data To Realm
        private func saveUserGroups(_ groupsData:  UserGroupModel )  {
            do {
                let realm = try Realm()
                try realm.write{
                    realm.add(groupsData.response.items, update: .modified)
                }
            }catch {
                print("Error Save Realm: \(error.localizedDescription)")
            }
        }
}




