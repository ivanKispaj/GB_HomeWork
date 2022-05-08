//
//  getUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//

import UIKit
import RealmSwift

extension InternetConnections {
    func getUserWall(for owner_id: String, completion: @escaping(Result<UserWallModel,Error>) -> ()) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        print(owner_id)
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: owner_id),
            URLQueryItem(name: "filter", value: "owner"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = self.urlComponents.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
 
                let decode = JSONDecoder()
                let result = try decode.decode(UserWallModel.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
                print("Erorr json data")
            }
        }.resume()
        
    }
}



