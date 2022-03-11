//
//  AvatarCourusel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit

class AvatarCourusel: UIView {

    @IBOutlet weak var circleViewImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
     
    override func layoutSubviews() {
        circleViewImage.layer.cornerRadius = bounds.height/2
    }

}
