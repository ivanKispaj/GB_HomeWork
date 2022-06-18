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
            URLQueryItem(name: "v", value: "5.131")
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
                let queue = DispatchQueue.global(qos: .utility)
                queue.async {
                    self.realmService.updateData(result.response.items)
                }
                
                
            }catch {
                print(InternetError.parseError)
                
            }
        }.resume()
    }
    
}




