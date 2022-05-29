//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
import AVKit
import RealmSwift

class HomeNewsTableViewController: UITableViewController {
   
    var playIndexPath: [IndexPath]?
 
    var newsRealmToken: NotificationToken?
    var realmService = RealmService()
    var nextViewData: [ImageAndLikeData?] = [nil]
    var newsData: [[CellType : NewsCellData]]? {
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
        registerCells()
    
 

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadNewsData()
      
    }
    
    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
 
        if self.newsData == nil {
            return 0
        }else {
        return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = self.newsData {
            return news.count
        }
        return 0
       
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is NewsVideoCell {
            let dataCell = cell as! NewsVideoCell
            if dataCell.player != nil {
                DispatchQueue.main.async {
                    dataCell.player.pause()
                }
                
            }
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is NewsVideoCell {
            let dataCell = cell as! NewsVideoCell
            if dataCell.player != nil {
                DispatchQueue.main.async {
                    dataCell.player.play()
                }
                
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let news = newsData?[indexPath.row].first else {
            preconditionFailure("Error cell")
        }
     
        let cellType = news.key
        let data = news.value
        switch cellType {
            
        case .photo:
             let cell: SinglePhotoAndTextTableViewCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCellForPhoto(from: data, linkStatus: false)
            
            return cell
        case .link:
            let cell: SinglePhotoAndTextTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCellForPhoto(from: data, linkStatus: true)
            return cell
        case .video:
            let cell: NewsVideoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.videoData = data
                cell.configureCellForVideo(form: data)
            return cell
        case .post:
            let cell: NewsPostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCellForPost(from: data)
            return cell
        case .gallary:
            print("gallary")
            let cell: NewsGallaryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setCellData(from: data)
            return cell
        case .photoLink:
            let cell: SinglePhotoAndTextTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCellForPhoto(from: data, linkStatus: false)
            return cell
        case .uncnown:
           print("uncnown")
        }
       
        let cell: NewsPostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.newsPostTextLabel.text = " Failure load Data!!!"
        return cell
    }
//MARK: - Регистрация кастомных ячеек таблицы
    private func registerCells() {
        
        self.tableView.register(SinglePhotoAndTextTableViewCell.self)
        self.tableView.register(NewsPostCell.self)
        self.tableView.register(NewsVideoCell.self)
        self.tableView.register(NewsGallaryCell.self)
    }

}




