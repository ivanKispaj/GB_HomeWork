//
//  LoadAndSaveNewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//

import UIKit
import RealmSwift

//MARK: - Получаем новости для пользователя
extension InternetConnections {
    func getUserNews() {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "filters", value: "post, photo, wall_photo"),
            URLQueryItem(name: "v", value: "5.131"),
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
                let result = try decode.decode(NewsDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.saveNewsData(result)
                }
                
            }catch {
                print(InternetError.parseError)
            }
        }.resume()
    }
    
    //MARK: - Save Wall Data To Realm
        private func saveNewsData(_ newsData:  NewsDataModel) {
            
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL!)
                realm.beginWrite()
                realm.add(newsData.response)
                try realm.commitWrite()
                
            }catch {
                print("Error Save Realm: \(error.localizedDescription)")
            }
        }
}



