//
//  getUserGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import Foundation

extension InternetConnections {
    
    func getUserGroups(for user_id: String ) {
    //    guard let user_id = NetworkSessionData.shared.userId else { return }
        guard let access_token = NetworkSessionData.shared.token else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity, city, fixed_post, description, counters"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "count", value: "10"),
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
            }catch {
                print("Erorr json data")
            }
        }.resume()
        
    }
}
