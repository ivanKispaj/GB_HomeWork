//
//  NewsGallaryCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.05.2022.
//

import UIKit

class NewsGallaryCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, DequeuableProtocol{
    @IBOutlet weak var newsTextLabel: UILabel!
    
    @IBOutlet weak var newsGallaryCollection: UICollectionView!
    @IBOutlet weak var newsGallaryUserAvatar: UIImageView!
    @IBOutlet weak var newsGallaryUserName: UILabel!
    @IBOutlet weak var newsGallaryUserSeen: UILabel!
    @IBOutlet weak var newsgallaryLikeCount: UILabel!
    @IBOutlet weak var newsGallarySeenCount: UILabel!
    var imageGallaryData: [PhotoDataNews]? {
        didSet {
            DispatchQueue.main.async {
                self.countCell = 0
                self.newsGallaryCollection.reloadData()
            }
        }
    }
    var countCell: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newsGallaryCollection.delegate = self
        self.newsGallaryCollection.dataSource = self
   //     self.newsGallaryCollection.collectionViewLayout = CastomCollectionLayout()
        self.newsGallaryCollection.register(NewsCollectionViewCell.self)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let data = self.imageGallaryData  {
            if data.count >= 4 {
            return 2
            }
            return 1
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.imageGallaryData {
            if data.count < 4 {
                return 1
            }else {
                return 2
            }
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.newsGallaryImageset.loadImageFromUrlString(self.imageGallaryData![self.countCell].url)
        self.countCell += 1
        return cell
    }
    

    func setCellData(from data: NewsCellData) {
        self.countCell = 0
        self.imageGallaryData = data.newsImage
        self.newsgallaryLikeCount.text = String(data.newsLikeCount)
        self.newsGallarySeenCount.text = String(data.newsSeenCount)
        self.newsGallaryUserName.text = data.newsUserName
        self.newsTextLabel.text = data.newsText
        self.newsGallaryUserAvatar.image = UIImage(data: data.newsUserLogo)
        self.newsGallaryUserSeen.text = data.date.unixTimeConvertion()
      
        
    }
    
}
