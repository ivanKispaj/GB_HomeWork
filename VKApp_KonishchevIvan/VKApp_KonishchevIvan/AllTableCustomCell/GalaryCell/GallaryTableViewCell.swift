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
    var delegateFrameImages: SetFrameImages!
    var gallaryData: [ImageAndLikeData]! {
        willSet {
            self.gallaryCollection.reloadData()
        }
    }
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
        guard self.gallaryData != nil else { return cell}
        cell.gallaryImage.contentMode = .scaleAspectFill

            let imgUrl = self.gallaryData[self.countCell].image
        if imgUrl.isUrlString() {
            let url = URL(string: imgUrl)
            DispatchQueue.main.async {
                   let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                   cell.gallaryImage.image  = UIImage(data: data!)
            }
        }else {
            cell.gallaryImage.image = UIImage(named: "noFoto")
        }
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
        self.delegate.selectRow(nextViewData: self.gallaryData)
        // Выбранная ячейка коллекции!!
       
    }
    

}
