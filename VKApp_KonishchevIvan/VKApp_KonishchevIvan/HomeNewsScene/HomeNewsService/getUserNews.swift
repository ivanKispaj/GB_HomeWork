//
//  getUserNews.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

//MARK: - Получаем новости для пользователя
extension InternetConnections {
    func getUserNews( completion: @escaping(Result<NewsDataModel,Error>) -> ()) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "filters", value: "post, photo, wall_photo"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        guard let url = self.urlComponents.url else { return }
        let request = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {

                let decode = JSONDecoder()
                let result = try decode.decode(NewsDataModel.self, from: data)
                self.seveNewsData(result.response)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


private extension InternetConnections {
    func seveNewsData(_  news: NewsResponse) {
           DispatchQueue.main.async {
                let realmDB = try!  Realm()
                //   print(realmDB.configuration.fileURL!)
                    do {
                        realmDB.beginWrite()
                        realmDB.add(news)
                        try realmDB.commitWrite()
                              
                           
                    }catch let error as NSError {
                        print("Something went wrong: \(error.localizedDescription)")
                    }
            }
    }
}
