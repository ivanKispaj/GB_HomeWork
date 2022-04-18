//
//  getListOfFriends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit

extension InternetConnections {
    func getListOfFirends(for user_id: String, completion: @escaping(Result<Friendss,Error>) -> ()) {
        guard let access_token = NetworkSessionData.shared.token else { return }
 //       var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/friends.get"
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "fields", value: "photo_50, city, last_seen, online "),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "20")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            let decode = JSONDecoder()
            do {
        
                let res = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(res)
            let result = try decode.decode(Friendss.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


