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
    var newsArray: [[CellType : [NewsCellData]]]! {
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
        self.loadNewsData()
        
        self.currentOrientation = UIDevice.current.orientation
        tableView.register(UINib(nibName: "SinglePhotoAndTextTableViewCell", bundle: nil), forCellReuseIdentifier: "SinglePhotoAndTextCell")
    }


    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
 
        if self.newsArray == nil {
            return 0
        }else {
        return newsArray.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        let dat = self.newsArray[section]
        let count = dat.first?.value.count
        return count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
            preconditionFailure("Error")
        }
        let array = newsArray?[indexPath.section].first
        let data = array?.value[indexPath.row]
        cell.newsData = data
// передаем контроллер и текущий индекс патч в делегат likecontroll!!!
        cell.likeControll.delegate = self
        cell.likeControll.indexPath = indexPath
// устанавливаем данные для отображения
        
        cell.newsUserAvatar.image = UIImage(data: data!.newsUserLogo)
      //  cell.newsUserAvatar.loadImageFromUrlString(data!.newsUserLogo)
        cell.newsTextView.text = data?.newsDescription
        cell.newsUserName.text = data?.newsUserName
        let counLike: String = String((data?.newsLikeCount)!)
        cell.newsLikeLable.text = counLike
        cell.newsUserApdateTime.text = unixTimeConvertion(unixTime: Double(data!.date))
        cell.seenViewLable.text = String(data!.newsSeenCount)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Подготовить segue к переходу на другой контроллер просмотра фото
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // сделать переход на просмотр фото
        }
        
    
}




