//
//  getPhotoUser.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit

extension InternetConnections {
    func getPhotoUser(for owner_id: String) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: owner_id),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "no_service_albums", value: "1"),
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
