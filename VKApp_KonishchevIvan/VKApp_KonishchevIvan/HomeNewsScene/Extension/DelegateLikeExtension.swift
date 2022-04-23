//
//  DelegateLikeExtension.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//

import UIKit

// MARK: - методы для делегата like controll !!
extension HomeNewsTableViewController: ProtocolLikeDelegate {

    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let countLike = newsArray![indexPath.row].newsLike.count
        let likeStatus = false
        return [countLike: likeStatus]
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        //self.newsArray![indexPath.row].newsLike.count = likeStatus
       // self.newsArray![indexPath.row].newsLike.count = countLike
    }
}
