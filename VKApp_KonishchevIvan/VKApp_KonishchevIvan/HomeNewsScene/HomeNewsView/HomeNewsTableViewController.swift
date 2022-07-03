//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
import AVKit
import RealmSwift

class HomeNewsTableViewController: UITableViewController, UpdateCellData {
    
    var toggle = false
    var newsTextheight: CGFloat = 100
    var lastDate: String?
    var playIndexPath: [IndexPath]?
    private var photoService: PhotoCacheService?
    private var vieoService: VideoLoadService?
    var newsRealmToken: NotificationToken?
    var realmService: RealmService!
    var nextViewData: [ImageAndLikeData]? = nil
    var newsData: [[CellType : NewsCellData]]?
    
    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realmService = RealmService()
        self.setupRefreshControll()
        self.setNotificationToken()
        self.currentOrientation = UIDevice.current.orientation
        registerCells()
        self.loadNewsData()
        self.photoService = PhotoCacheService(container: self.tableView)
        self.vieoService = VideoLoadService(container: self.tableView)
    }
    
    // MARK: - Table view data source
    private func setupRefreshControll() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.attributedTitle = NSAttributedString("Обновляем...")
        self.tableView.tintColor = UIColor(named: "AppButton")
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshActions), for: .valueChanged)
    }
    
    @objc func refreshActions() {
        self.tableView.refreshControl?.endRefreshing()
        guard let date = NetworkSessionData.shared.lastSeen else {
            let date = NSDate() // current date
            var unixtime = date.timeIntervalSince1970 as Double
            unixtime = (unixtime.rounded()) - (1 * 24 * 60 * 60) // минус 1 сутки в секундах
            self.getNewsFromDate(fromDate: String(unixtime))
            return
            
        }
        self.getNewsFromDate(fromDate: date)
    }
    
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
            cell.indexPath = indexPath
            cell.control = self
            cell.textHeight = self.newsTextheight
            cell.toggle = self.toggle
            cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
            
            
            return cell
        case .link:
            let cell: SinglePhotoAndTextTableViewCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            guard let photo = data.newsImage.first, let image = photoService?.photo(atIndexPath: indexPath, byUrl: photo.url) else {
                let image = UIImage(named: "noFoto")!
                cell.configureCellForPhoto(from: data, linkStatus: false, image: image)
                return cell
            }
            cell.indexPath = indexPath
            cell.control = self
            
            cell.configureCellForPhoto(from: data, linkStatus: true, image: image)
            return cell
        case .video:
            let cell: NewsVideoCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.videoData = data
            cell.configureCellForVideo(form: data)
            if let player = vieoService?.video(atIndexPath: indexPath, byData: data) {
                cell.playerViewController.player = player
                cell.playerViewController.player?.play()
            }
            return cell
        case .post:
            let cell: NewsPostCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCellForPost(from: data)
            return cell
        case .gallary:
            let cell: NewsGallaryCell = self.tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.indexPath = indexPath
            cell.control = self
            cell.textHeight = self.newsTextheight
            cell.toggle = self.toggle
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
        
        let errorCell: NewsPostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        errorCell.newsPostTextLabel.text = " Failure load Data!!!"
        return errorCell
    }
    
    //MARK: - Регистрация кастомных ячеек таблицы
    private func registerCells() {
        
        self.tableView.register(SinglePhotoAndTextTableViewCell.self)
        self.tableView.register(NewsPostCell.self)
        self.tableView.register(NewsVideoCell.self)
        self.tableView.register(NewsGallaryCell.self)
    }
    
    func updateCellData(with indexPath: IndexPath, textHeight: CGFloat, togle: Bool) {
        self.newsTextheight = textHeight
        self.toggle = togle
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows!, with: .none)
        }
    }
}




