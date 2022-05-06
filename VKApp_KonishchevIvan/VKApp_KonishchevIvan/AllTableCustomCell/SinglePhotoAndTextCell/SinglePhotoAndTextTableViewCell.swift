//
//  SinglePhotoAndTextTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class SinglePhotoAndTextTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var likeControll: ControlForLike!
    
  
    
    @IBOutlet weak var newsCollection: UICollectionView!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsUserAvatar: UIImageView!
    @IBOutlet weak var newsUserName: UILabel!
    @IBOutlet weak var newsUserApdateTime: UILabel!
    @IBOutlet weak var newsLikeImage: UIImageView!
    @IBOutlet weak var newsLikeLable: UILabel!
    @IBOutlet weak var seenViewLable: UILabel!
    
    var newsData: NewsCellData! {
        didSet {
            DispatchQueue.main.async {
                self.newsCollection.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newsCollection.delegate = self
        self.newsCollection.dataSource = self
        self.newsCollection.register(UINib(nibName: "NewsPhotoAndTextCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsPhotoAndTextID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsCollection.dequeueReusableCell(withReuseIdentifier: "NewsPhotoAndTextID", for: indexPath) as? NewsPhotoAndTextCollectionViewCell else {
            preconditionFailure("Error")
        }
        
        let url = newsData.newsImage
        cell.newsImage.loadImageFromUrlString(url)
        return cell
    }

}

