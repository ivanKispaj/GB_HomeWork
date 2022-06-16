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
    var imageGallaryData: [PhotoDataNews]?
    
    var countCell: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newsGallaryCollection.delegate = self
        self.newsGallaryCollection.dataSource = self
        self.newsGallaryCollection.register(NewsCollectionViewCell.self)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let data = self.imageGallaryData  {
            switch data.count {
                
            case 1...2:
                return 1
            case 3...4:
                return 2
            case 5...20:
                return 3
            default:
                return 0
            }
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.imageGallaryData {
            switch data.count {
            case 1:
                return 1
            case 2:
                return 2
                
            case 3:
                if section == 0 {
                    return 2
                }else { return 1 }
            case 4:
                if section == 0 {
                    return 3
                }else {
                    return 1
                }
            case 5:
                if section == 0 || section == 2 {
                    return 2
                }else {
                    return 1
                }
            case 6:
                if section == 0 {
                    return 3
                }else if section == 2 {
                    return 2
                }else { return 1 }
                
            default:
                if section == 0 || section == 2 {
                    return 3
                }else { return 1 }
            }
            
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.white.cgColor
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
        self.newsGallaryCollection.reloadData()
        
    }
    
}
