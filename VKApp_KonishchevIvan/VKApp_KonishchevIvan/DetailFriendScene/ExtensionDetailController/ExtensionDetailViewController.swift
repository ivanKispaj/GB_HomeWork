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
        let imgUrl = self.friendsSelectedd.photo50
        if verifyUrl(urlString: imgUrl) {
            let url = URL(string: imgUrl)
            DispatchQueue.main.async {
                   let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                   self.detailAvatarHeader.image  = UIImage(data: data!)
                self.detailUserNameLable.text = "\(self.friendsSelectedd.fName) \(self.friendsSelectedd.lName)"
            }
        }else {
            self.detailAvatarHeader.image = UIImage(named: "noFoto")
        }
       
    self.detailUserInfoLable.text = detailUserInfo
    let time = unixTimeConvertion(unixTime: self.friendsSelectedd.lastSeen!.time)
        if self.friendsSelectedd.online == 1 {
            self.detailUserAccountLable.textColor = UIColor.red
            self.detailUserAccountLable.text = "online"
           
        }else {
            self.detailUserAccountLable.textColor = UIColor.systemGray2
            self.detailUserAccountLable.text = "был(а) : \(time)"
        }
  
    self.detailButtonMessage.setTitle("Сообщение", for: .normal)
    self.detailButtonMessage.setTitleColor(UIColor.white, for: .normal)
    self.detailButtonCall.setTitle("Звонок", for: .normal)
    self.detailButtonCall.setTitleColor(UIColor.white, for: .normal)
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
