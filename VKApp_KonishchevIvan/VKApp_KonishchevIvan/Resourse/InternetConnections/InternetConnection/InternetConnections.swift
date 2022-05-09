//
//  InternetConnections.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit
import RealmSwift


enum InternetError: Error {
    case requestError(Error)
    case parseError
}

// MARK: - Класс для доступа в интернет по умолчанию протокол(схема) hhtps, host и path надо передавать при создании соединения
final class InternetConnections {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    var urlComponents: URLComponents!
    
    init (scheme: String = "https", host: String, path: String) {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = scheme
        self.urlComponents.host = host
        self.urlComponents.path = path
    }
}




