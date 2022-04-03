//
//  ExtensionDetailViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit

// MARK: - добавляет текст на кнопки в header в DetailUserViewController
extension DetailUserTableViewController {
    func setHeaderDetailView(){
    self.detailAvatarHeader.image = detailAvatar
    self.detailUserNameLable.text = detailUsername
    self.detailUserInfoLable.text = detailUserInfo
    self.detailUserAccountLable.text = detailUserVisitInfo
    self.detailButtonMessage.setTitle("Сообщение", for: .normal)
    self.detailButtonMessage.setTitleColor(UIColor.white, for: .normal)
    self.detailButtonCall.setTitle("Звонок", for: .normal)
    self.detailButtonCall.setTitleColor(UIColor.white, for: .normal)
    }
}
