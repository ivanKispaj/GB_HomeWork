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
    var photoService: PhotoCacheService?
    var newsRealmToken: NotificationToken?
    var realmService: RealmService!
    var nextViewData: [ImageAndLikeData]? = nil
    var newsData: [[CellType : NewsCellData]]?
    
    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realmService = RealmService()
        self.setNotificationToken()
        self.currentOrientation = UIDevice.current.orientation
        registerCells()
        self.loadNewsData()
        self.photoService = PhotoCacheService(container: self.tableView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tableView = nil
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
            guard let playerController = dataCell.playerViewController else {return}
            if playerController.player != nil {
                
                dataCell.playerViewController.player!.pause()
                
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is NewsVideoCell {
            let dataCell = cell as! NewsVideoCell
            guard let playerController = dataCell.playerViewController else {return}
            if playerController.player != nil {
                
                dataCell.playerViewController.player!.play()
                
                
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
       
            guard let photo = data.newsImage.first, let image = photoService?.photo(atIndexPath: indexPath, byUrl: photo.url) else {
                let image = UIImage(named: "noFoto")!
                cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
                return cell
            }
           
            cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
           
            
            return cell
        case .link:
            let cell: SinglePhotoAndTextTableViewCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
       
            guard let photo = data.newsImage.first, let image = photoService?.photo(atIndexPath: indexPath, byUrl: photo.url) else {
                let image = UIImage(named: "noFoto")!
                cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
                return cell
            }
            cell.configureCellForPhoto(from: data, linkStatus: true, image: image)
            return cell
        case .video:
            let cell: NewsVideoCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.videoData = data
            cell.configureCellForVideo(form: data)
            return cell
        case .post:
            let cell: NewsPostCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCellForPost(from: data)
            return cell
        case .gallary:
            print("gallary")
            let cell: NewsGallaryCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setCellData(from: data)
            return cell
        case .photoLink:
            let cell: SinglePhotoAndTextTableViewCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
       
            guard let photo = data.newsImage.first, let image = photoService?.photo(atIndexPath: indexPath, byUrl: photo.url) else {
                let image = UIImage(named: "noFoto")!
                cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
                return cell
            }
            cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
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




