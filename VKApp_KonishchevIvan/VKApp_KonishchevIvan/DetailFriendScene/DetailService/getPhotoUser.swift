//
//  getPhotoUser.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit

extension InternetConnections {
    func getPhotoUser(for owner_id: String, completion: @escaping(Result<PhotoUser,Error>) -> ()) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: owner_id),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "no_service_albums", value: "0"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "skip_hidden", value: "0")
        ]
        guard let url = self.urlComponents.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let decode = JSONDecoder()
                let result = try decode.decode(PhotoUser.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
                print("Erorr json data")
            }
        }.resume()
        
    }
}



