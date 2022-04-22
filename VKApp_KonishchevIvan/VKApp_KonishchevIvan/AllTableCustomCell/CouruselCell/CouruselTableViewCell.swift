//
//  CouruselTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit


class CouruselTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var CouruselCollection: UICollectionView!
    var collectionData: [FriendsItems]! {
        willSet {
            CouruselCollection.reloadData()
        }
    }
    
    
    var delegate: TableViewDelegate!
    
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
       
         let imgUrl = self.collectionData![indexPath.row].photo50
         if imgUrl.isUrlString(){
             let url = URL(string: imgUrl)
             DispatchQueue.main.async {
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    cell.imageCouruselCell.image  = UIImage(data: data!)
             }
         }else {
             cell.imageCouruselCell.image = UIImage(named: "noFoto")
         }

         cell.lableForDetailsCorusel.text = ("\(self.collectionData![indexPath.row].fName) \(self.collectionData![indexPath.row].lName)")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        print("select: \(self.collectionData![indexPath.row].id)")

        
    }
}
