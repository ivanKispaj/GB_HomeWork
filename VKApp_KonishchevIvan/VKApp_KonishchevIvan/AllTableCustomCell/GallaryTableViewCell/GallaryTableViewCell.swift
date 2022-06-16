//
//  GalaryTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class GallaryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, DequeuableProtocol {

    @IBOutlet weak var gallaryCollection: UICollectionView!
    weak var delegate: TableViewDelegate!
    weak var delegateFrameImages: SetFrameImages!
    var gallaryData: [ImageAndLikeData]! {
        didSet {
            self.gallaryCollection.reloadData()
        }
    }
    var countCell: Int = 0
    var delegateIndexPath: IndexPath!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.gallaryCollection.delegate = self
        self.gallaryCollection.dataSource = self
        self.gallaryCollection.register(GallaryCollectionViewCell.self)
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.gallaryData != nil && self.gallaryData.count == 0 {
            return 0
        }else if self.gallaryData != nil && self.gallaryData.count >= 4 {
            return 2
        }
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.gallaryData == nil {
        return 0
        }else if self.gallaryData.count < 4 {
            return 1
        }
        return 2
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GallaryCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.gallaryImage.contentMode = .scaleAspectFill
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 4
            cell.gallaryImage.loadImageFromUrlString(self.gallaryData[self.countCell].image)
            self.countCell += 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var frameArray: [CGRect] = []
        let currentFrame: CGRect = collectionView.cellForItem(at: indexPath)!.frame
        let visibleCells = collectionView.visibleCells
        for images in visibleCells {
            frameArray.append(images.frame)
        }
        var currentImage = 0
        switch indexPath.section {
         
        case 0:
            currentImage = indexPath.row
        case 1:
            currentImage = indexPath.row + 2
        default:
            print("IndexOutOfRange")
        }
        
        self.delegateFrameImages.setCurrentImage(currentImage)
        self.delegateFrameImages.setFrameImages(frameArray, currentFrame: currentFrame) 
        self.delegate.selectRow(nextViewData: self.gallaryData, indexPath: self.delegateIndexPath)
        // Выбранная ячейка коллекции!!
       
    }
    

}
