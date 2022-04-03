//
//  ProtocolLikeDelegate.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 01.04.2022.
//

import Foundation

protocol ProtocolLikeDelegate: AnyObject {
   func getCountLike(for indexPath: IndexPath) -> [Int: Bool]
   func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath)
}

