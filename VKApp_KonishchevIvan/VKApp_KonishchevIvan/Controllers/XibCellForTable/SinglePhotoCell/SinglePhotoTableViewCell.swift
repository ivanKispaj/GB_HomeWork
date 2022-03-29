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

    var singlePhoto: ImageAndLikeData!
    var delegate: TableViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.singlCollection.delegate = self
        self.singlCollection.dataSource = self
        self.singlCollection.register(UINib(nibName: "SingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleCollectionID")
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleCollectionID", for: indexPath) as? SingleCollectionViewCell else {
            preconditionFailure("Error")
        }
       // let photo = self.singlePhoto.last
        cell.singlePhoto.image = self.singlePhoto.image //as? UIImage ?? UIImage(named: "WinstonCherchil")
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let photo:[ImageAndLikeData] = [self.singlePhoto]
        
        self.delegate.selectRow(nextViewData: photo)
    }
}
