//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
import AVKit
import RealmSwift
//import AVFoundation

class HomeNewsTableViewController: UITableViewController {
 
    
    
    var newsRealmToken: NotificationToken?
    var realmService = RealmService()
    var nextViewData: [ImageAndLikeData?] = [nil]
    var newsArray: [[CellType : NewsCellData]]! {
        didSet {
            DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
        }
    }

    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNotificationToken()
        self.currentOrientation = UIDevice.current.orientation
        tableView.register(UINib(nibName: "SinglePhotoAndTextTableViewCell", bundle: nil), forCellReuseIdentifier: "SinglePhotoAndTextCell")
        tableView.register(UINib(nibName: "NewsPostCell", bundle: nil), forCellReuseIdentifier: "NewsPostCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        super.viewWillAppear(true)
        self.loadNewsData()
    }
    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
 
        if self.newsArray == nil {
            return 0
        }else {
        return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        print(self.newsArray.count)
        return self.newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let array = newsArray?[indexPath.row].first else {
            preconditionFailure("Error cell")
        }
        let cellType = array.key
        let data = array.value
        switch cellType {
            
        case .photo:
          
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
                preconditionFailure("Error")
            }
            if let image = data.newsImage.first {
                cell.newsImage.loadImageFromUrlString(image.url)
                cell.newsData = image
            }
           
            cell.newsTextView.text = data.newsText
            cell.newsUserName.text = data.newsUserName
            cell.newsLikeLable.text = String(data.newsLikeCount)
            cell.newsUserAvatar.image = UIImage(data: data.newsUserLogo)
            cell.imageParentView.backgroundColor = .clear
            cell.newsUserApdateTime.text = data.date.unixTimeConvertion()
            cell.seenViewLable.text = String(data.newsSeenCount)
            cell.lableOnPhoto.text = ""
            cell.lableUserNameOnPhoto.text = ""
            return cell
        case .link:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
                preconditionFailure("Error")
            }
            if let image = data.newsImage.first {
                cell.newsImage.loadImageFromUrlString(image.url)
                cell.newsData = image
            }
            cell.newsTextView.text = data.newsText
            cell.newsUserName.text = data.newsUserName
            cell.newsLikeLable.text = String(data.newsLikeCount)
            cell.newsUserAvatar.image = UIImage(data: data.newsUserLogo)
            cell.newsUserApdateTime.text = data.date.unixTimeConvertion()
            cell.seenViewLable.text = String(data.newsSeenCount)
            cell.lableOnPhoto.text = data.lableOnPhoto
            cell.lableUserNameOnPhoto.text = data.lableUserNameOnPhoto
            cell.imageParentView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.4388283451)
            
            return cell
        case .video:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
                preconditionFailure("Error")
            }
            if let image = data.firstFrame {
                cell.newsImage.loadImageFromUrlString(image.url)
                cell.newsData = image
            }
            cell.newsTextView.text = data.newsText
            cell.newsUserName.text = data.newsUserName
            cell.newsLikeLable.text = String(data.newsLikeCount)
            cell.newsUserAvatar.image = UIImage(data: data.newsUserLogo)
            cell.imageParentView.backgroundColor = .clear
            cell.newsUserApdateTime.text = data.date.unixTimeConvertion()
            cell.seenViewLable.text = String(data.newsSeenCount)
            cell.lableOnPhoto.text = ""
            cell.lableUserNameOnPhoto.text = ""
            
            return cell
        case .post:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPostCell", for: indexPath) as? NewsPostCell else {
                preconditionFailure("Error")
            }
            cell.newsPostTextLabel.text = data.newsText
            cell.newsPostUserName.text = data.newsUserName
            cell.newsPostUserSeen.text = data.date.unixTimeConvertion()
            cell.newsPostLikeCount.text = String(data.newsLikeCount)
            cell.newsPostSeenCount.text = String(data.newsSeenCount)
            cell.newsPostUserAvatar.image = UIImage(data: data.newsUserLogo)
            return cell
        case .gallary:
            print("Gallary")
        case .photoLink:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
                preconditionFailure("Error")
            }
            if let image = data.newsImage.first {
                cell.newsImage.loadImageFromUrlString(image.url)
                cell.newsData = image
            }
            cell.newsTextView.text = data.newsText
            cell.newsUserName.text = data.newsUserName
            cell.newsLikeLable.text = String(data.newsLikeCount)
            cell.newsUserAvatar.image = UIImage(data: data.newsUserLogo)
            cell.newsUserApdateTime.text = data.date.unixTimeConvertion()
            cell.seenViewLable.text = String(data.newsSeenCount)
            cell.imageParentView.backgroundColor = .clear
            cell.lableOnPhoto.text = ""
            cell.lableUserNameOnPhoto.text = ""
            return cell
        case .uncnown:
           print("uncnown")
        }
       
       
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPostCell", for: indexPath) as? NewsPostCell else {
            preconditionFailure("Error")
        }
        cell.newsPostTextLabel.text = " Failure load Data!!!"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // сделать переход на просмотр фото
        }
        
    
}




