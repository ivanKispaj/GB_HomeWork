//
//  InternetConnections.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit
// MARK: - Класс для доступа в интернет по умолчанию протокол(схема) hhtps, host и path надо передавать при создании соединения
class InternetConnections {
    var urlComponents: URLComponents!
    init (scheme: String = "https", host: String, path: String) {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = scheme
        self.urlComponents.host = host
        self.urlComponents.path = path
    }
}
