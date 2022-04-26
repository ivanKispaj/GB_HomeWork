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
        let data = self.newsArray?[indexPath.section].first?.value[indexPath.row]
        let countLike =  data?.newsLike.count
        var likeStatus = false
        if data?.newsLike.likeStatus != 0 {
            likeStatus = true
        }
        return [countLike!: likeStatus]
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        var data = self.newsArray?[indexPath.section].first?.value[indexPath.row]
        data?.newsLike.count = countLike
        var likeStat = 0
        if likeStatus {
            likeStat = 1
        }else {
            likeStat = 0
        }
        data?.newsLike.likeStatus = likeStat
    }
}
