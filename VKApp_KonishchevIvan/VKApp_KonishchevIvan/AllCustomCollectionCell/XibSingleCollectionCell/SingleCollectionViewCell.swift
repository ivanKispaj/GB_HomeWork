//
//  SingleCollectionViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class SingleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var singlePhoto: UIImageView!
    private var animateImage = UIViewPropertyAnimator()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
