//
//  GalaryTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class GallaryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var gallaryCollection: UICollectionView!
    var delegate: TableViewDelegate!
    var gallaryData: [ImageAndLikeData] = []
    var countCell: Int = 0
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.gallaryCollection.delegate = self
        self.gallaryCollection.dataSource = self
        self.gallaryCollection.register(UINib(nibName: "GallaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GallaryCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCollectionCell", for: indexPath) as? GallaryCollectionViewCell else {
            preconditionFailure("Error")
        }
        let image = gallaryData[self.countCell].image
        cell.gallaryImage.image = image
        self.countCell += 1
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.delegate.selectRow(nextViewData: self.gallaryData)
        // Выбранная ячейка коллекции!!
        print("section: \(indexPath.section)\nrow: \(indexPath.row)")
    }
    

}
