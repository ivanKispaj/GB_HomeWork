//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

protocol TableViewDelegate {
    var nextViewData: [ImageAndLikeData] {set get}
    func selectRow(nextViewData: [ImageAndLikeData])
}

class HomeNewsTableViewController: UITableViewController{
    

    var nextViewData: [ImageAndLikeData?] = [nil]
    var newsArray:[NewsData]? = nil
    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  controll.addTarget(self, action: #selector (likeIsTapped), for: .valueChanged)
        
        self.currentOrientation = UIDevice.current.orientation
        self.newsArray = DataController.shared.getDataNews()
        tableView.register(UINib(nibName: "SinglePhotoAndTextTableViewCell", bundle: nil), forCellReuseIdentifier: "SinglePhotoAndTextCell")
    }


    // MARK: - Table view data source

    @objc func likeIsTapped() {
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsArray!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
            preconditionFailure("Error")
        }
        let newsText = (self.newsArray![indexPath.row].newsText)!
        let newsImage = (self.newsArray![indexPath.row].newsImage)
        cell.newsTextView.text = newsText
        cell.controllerNewsImage = newsImage
        
// передаем контроллер и текущий индекс патч в делегат!!!
        cell.likeControll.delegate = self
        cell.likeControll.indexPath = indexPath
        
        cell.newsUserAvatar.image = UIImage(named: "abramovich")
        
        let countlike: String = String(newsArray![indexPath.row].newsImage!.likeLabel)
        cell.newsLikeLable.text = countlike
      
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PhotoGallaryPressetViewController else { return
        }
        destinationVC.dataCollection = self.nextViewData
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            let photo: [ImageAndLikeData?] = [self.newsArray![indexPath.row].newsImage]
            self.nextViewData = photo
            self.performSegue(withIdentifier: "NewsPhotoPreviewID", sender: nil)
        
        }
          
            
        
        
    }

    
}

extension HomeNewsTableViewController: ProtocolLikeDelegate {

    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let countLike = newsArray![indexPath.row].newsImage?.likeLabel
        let likeStatus = newsArray![indexPath.row].newsImage?.likeStatus
        return [countLike!: likeStatus!]
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.newsArray![indexPath.row].newsImage?.likeStatus = likeStatus
        self.newsArray![indexPath.row].newsImage?.likeLabel = countLike
    }
}
