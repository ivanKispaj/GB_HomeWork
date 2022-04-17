//
//  getGroupsByRequest.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import Foundation


extension InternetConnections {
    enum TypeCommunity: String {
        case group = "group"
        case page = "page"
        case event = "event"
    }
    func getGroupsByRequest(textRequset: String, typeCommunity: TypeCommunity) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "q", value: textRequset),
            URLQueryItem(name: "type", value: typeCommunity.rawValue),
            URLQueryItem(name: "city_id", value: "1"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "lang", value: "ru")
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
