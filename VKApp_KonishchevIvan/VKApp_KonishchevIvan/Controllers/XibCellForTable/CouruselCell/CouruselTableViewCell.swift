//
//  CouruselTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit


class CouruselTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var CouruselCollection: UICollectionView!
    var collectionData: [HisFirends]? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.CouruselCollection.dataSource = self
        self.CouruselCollection.delegate = self
        self.CouruselCollection.register(UINib(nibName: "CouruselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CouruselID1")
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.collectionData?.count ?? 0
         
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = CouruselCollection.dequeueReusableCell(withReuseIdentifier: "CouruselID1", for: indexPath) as? CouruselCollectionViewCell else { preconditionFailure("Error")
        }
         cell.imageCouruselCell.image = collectionData![indexPath.row].friendsAvatar
         cell.lableForDetailsCorusel.text = collectionData![indexPath.row].friendsName
        return cell
    }
}
