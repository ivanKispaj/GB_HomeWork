//
//  SinglePhotoTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class SinglePhotoTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var likeControll: ControlForLike!
    
    @IBOutlet weak var singlCollection: UICollectionView!
    @IBOutlet weak var singleLableUserName: UILabel!
    @IBOutlet weak var singleAvatarHeader: UIImageView!
    @IBOutlet weak var singleAdditionalInfo: UILabel!
    @IBOutlet weak var singlPhotoLikeLable: UILabel!
    @IBOutlet weak var singlePhotoLikeImage: UIImageView!
    @IBOutlet weak var singlePhotoSeenCount: UILabel!
    
    var singlePhoto: ImageAndLikeData! {
        didSet {
            self.singlCollection.reloadData()
        }
    }
    var delegate: TableViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.singlCollection.delegate = self
        self.singlCollection.dataSource = self
        self.singlCollection.register(UINib(nibName: "SingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleCollectionID")
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if singlePhoto != nil {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleCollectionID", for: indexPath) as? SingleCollectionViewCell else {
            preconditionFailure("Error")
        }
        
        cell.singlePhoto.loadImageFromUrlString(self.singlePhoto.image)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let photo:[ImageAndLikeData] = [self.singlePhoto]
        
        self.delegate.selectRow(nextViewData: photo)
    }

}
