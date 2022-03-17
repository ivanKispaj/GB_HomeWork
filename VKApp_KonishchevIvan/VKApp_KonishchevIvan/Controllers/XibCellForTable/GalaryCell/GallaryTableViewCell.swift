//
//  GalaryTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class GallaryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var gallaryCollection: UICollectionView!
    
    var gallaryData: GallaryPhoto? = nil
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
        return (gallaryData?.photo.count)!
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (gallaryData?.photo[section]!.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCollectionCell", for: indexPath) as? GallaryCollectionViewCell else {
            preconditionFailure("Error")
        }
        let image = gallaryData?.photo[indexPath.section]![indexPath.row]
        cell.gallaryImage.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "FullImageDetailID") as? FullImageDetailViewController else {
            preconditionFailure("Error view next controller!")
        }
        let navigationController = getControllerRoot()
        nextVC.imageFulls = gallaryData?.photo[indexPath.section]![indexPath.row]
        nextVC.modalPresentationStyle = .fullScreen
        navigationController!.show(nextVC, sender: self)
        // Выбранная ячейка коллекции!!
        print("section: \(indexPath.section)\nrow: \(indexPath.row)")
    }
    
    func getControllerRoot() -> UIViewController? {
        
        var keyWindow: UIWindow? {
          return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
        }
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                print(presentedViewController)
                topController = presentedViewController
               
            }
            print(topController)
            return topController
        }else {
            return nil
        }
    }

}
