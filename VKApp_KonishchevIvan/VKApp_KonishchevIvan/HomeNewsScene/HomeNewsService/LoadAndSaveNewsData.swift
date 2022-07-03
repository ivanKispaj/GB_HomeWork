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
            URLQueryItem(name: "filters", value: "post, photo, video"),
            URLQueryItem(name: "count", value: "15"),
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
                print(result.response.items.count)
                DispatchQueue.global(qos: .utility).async {
                    self.realmService.updateData(result.response)
                }
                
            }catch {
                print(InternetError.parseError)
            }
        }.resume()
    }
    
    
    func getUserNews(fromDate: String, completion: @escaping (Result<NewsResponse,Error>)->()) {
        
        guard let access_token = NetworkSessionData.shared.token else { return }
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "filters", value: "post, photo, video"),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "start_time", value: fromDate),
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
                DispatchQueue.global(qos: .utility).async {
                    let object = self.realmService.readData(NewsResponse.self)?.first
                    if object != nil {
                        self.realmService.deliteData(object!, cascading: true)
                        
                    }
                    self.realmService.updateData(result.response)
                }
                completion(.success(result.response))
                
            }catch {
                completion(.failure(error))
                print(InternetError.parseError)
            }
        }.resume()
    }
}



