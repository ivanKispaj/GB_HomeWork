//
//  NetvorkSessionData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.04.2022.
//

import Foundation

class NetworkSessionData {
    
    static var shared = NetworkSessionData()
    var token: String?
    var userId: Int?
    
    private init(){}
}
