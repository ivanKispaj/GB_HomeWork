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
    func getUserNews() async throws {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "filters", value: "post, photo, wall_photo"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        guard let url = self.urlComponents.url else { throw InternetError.parseError }
            do {
                let (data, _ ) = try await self.session.data(from: url)
                let decode = JSONDecoder()
                let result = try decode.decode(NewsDataModel.self, from: data)
                await saveNewsData(result)
            }catch {
                throw InternetError.parseError

            }
       
    }
    
    //MARK: - Save Wall Data To Realm
        private func saveNewsData(_ newsData:  NewsDataModel) async {
            if let realm = try? await Realm() {
                   do {
                       print(realm.configuration.fileURL!)
                       realm.beginWrite()
                       realm.add(newsData.response)
                       try realm.commitWrite()
//                       try realm.write{
//                           realm.add(newsData.response, update: .modified)
//                       }
                   } catch let error as NSError {
                       print("Something went wrong: \(error.localizedDescription)")
                   }
            }
        }
}



