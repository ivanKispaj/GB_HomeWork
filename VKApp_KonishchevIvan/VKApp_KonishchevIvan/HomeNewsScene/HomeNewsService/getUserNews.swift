//
//  getUserNews.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

extension InternetConnections {
    func getUserNews( completion: @escaping(Result<NewsModel,Error>) -> ()) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
          //  URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "filters", value: "post"),
         //   URLQueryItem(name: "fields", value: "photo_50, city, last_seen, online "),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "10")
        ]
        guard let url = self.urlComponents.url else { return }
        let request = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            let decode = JSONDecoder()
            do {
            let result = try decode.decode(NewsModel.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
