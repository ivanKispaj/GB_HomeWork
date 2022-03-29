//
//  PhotoGallaryPressetViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 19.03.2022.
//

import UIKit

class PhotoGallaryPressetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CastomlayoutDelegate {

    @IBOutlet weak var likeControll: ControlForLike!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heartLike: UIImageView!
    @IBOutlet weak var labelLike: UILabel!
    
    var numberImage: Int = 0
    var dataCollection: [ImageAndLikeData?] = [nil]
    override func viewDidLoad() {
        super.viewDidLoad()
        likeControll.delegate = self
        if let castomLayout = collectionView?.collectionViewLayout as? CastomHorizontalView {
            castomLayout.delegate = self
           
        }
       
        collectionView.register(UINib(nibName: "SingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleCollectionID")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleCollectionID", for: indexPath) as? SingleCollectionViewCell else {
            preconditionFailure("ErrorCellGallaryPresset")
        }

        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.white.cgColor
        var indexP = indexPath
        indexP.row = numberImage
        self.likeControll.indexPath = indexP
        let likeStatus = dataCollection[numberImage]?.likeStatus
  
      
        if likeStatus! {
          
                heartLike.image = UIImage(systemName: "suit.heart.fill")
                heartLike.tintColor = UIColor.red
         
        
        } else {
          
                heartLike.image = UIImage(systemName: "suit.heart")
                heartLike.tintColor = UIColor.systemGray6
           
           
        }
        let LikeCount = dataCollection[numberImage]?.likeLabel
        labelLike.text = String(LikeCount!)
        cell.singlePhoto.image = dataCollection[indexPath.row]?.image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, withWidth width: CGFloat) -> CGSize {
        let imageSize: CGSize = (dataCollection[indexPath.row]?.image.size)!
        return imageSize
    }
    func setLikeData(numberImage: Int) {
        self.numberImage = numberImage
        collectionView.reloadData()
    }
    func getLikeData(numberImage: Int) -> Int {
        return self.numberImage
    }
    

}
    


extension PhotoGallaryPressetViewController: ProtocolLikeDelegate {

    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let countLike = dataCollection[indexPath.row]?.likeLabel
        let likeStatus = dataCollection[indexPath.row]?.likeStatus
        return [countLike!: likeStatus!]
    }



    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.dataCollection[indexPath.row]?.likeLabel = countLike
        self.dataCollection[indexPath.row]?.likeStatus = likeStatus
    }
}
