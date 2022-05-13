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
        DispatchQueue.main.async {
            self.detailUserNameLable.text = self.friendsSelectedd.userName
            self.detailUserInfoLable.text = self.friendsSelectedd.status
        }
        
        self.detailAvatarHeader.image = UIImage(data: self.friendsSelectedd.photo)
       
        let time = self.friendsSelectedd.lastSeenDate.unixTimeConvertion()
        if self.friendsSelectedd.online {
            self.detailUserAccountLable.textColor = UIColor.red
            self.detailUserAccountLable.text = "online"
           
        }else {
            DispatchQueue.main.async {
                self.detailUserAccountLable.textColor = UIColor.systemGray2
                self.detailUserAccountLable.text = "был(а) : \(time)"
            }
           
        }

            self.detailButtonMessage.setTitle("Сообщение", for: .normal)
            self.detailButtonMessage.setTitleColor(UIColor.white, for: .normal)
            self.detailButtonCall.setTitle("Звонок", for: .normal)
            self.detailButtonCall.setTitleColor(UIColor.white, for: .normal)
  
    }

}
