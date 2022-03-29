//
//  ProtocolLikeDelegate.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 26.03.2022.
//

import UIKit

 protocol ProtocolLikeDelegate: AnyObject {
    func getCountLike(for indexPath: IndexPath) -> [Int: Bool]
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath)
  //  func getCountLikeGallary(for numberImage: Int) ->[Int: Bool]
}
