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
        let data = (self.newsArray?[indexPath.section].first?.value[indexPath.row])!
        let countLike =  data.newsLikeCount
        return [countLike: data.newsLikeStatus]
    }

    
// В процессе доработки!!
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
//        if let data = self.newsArray?[indexPath.section].first?.value[indexPath.row] {
//       //     data.newsLikeCount = countLike
//       //     data.newsLikeStatus = likeStatus
//        }
    }
}
