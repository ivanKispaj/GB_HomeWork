//
//  AvatarUIView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 27.02.2022.
//

import UIKit

 class AvatarUIView: UIView {
   
    @IBOutlet weak var circleViewImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
     
    override func layoutSubviews() {
        circleViewImage.layer.cornerRadius = bounds.height/2
    }
}
