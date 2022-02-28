//
//  AvatarUIView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 27.02.2022.
//

import UIKit

class AvatarUIView: UIView {

    @IBOutlet weak var shadowViewCell: UIView!
    @IBOutlet weak var circleViewImage: UIImageView!
    
    
    var shadowColor: CGColor = UIColor(named: "AvatarShadow")!.cgColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowViewCell.layer.shadowColor = shadowColor
        shadowViewCell.layer.shadowOffset = .zero
        shadowViewCell.layer.shadowRadius = 7
        shadowViewCell.layer.shadowOpacity = 0.7
    }
    override func layoutSubviews() {
        circleViewImage.layer.cornerRadius = bounds.height/2
        shadowViewCell.layer.cornerRadius = bounds.height/2
        self.layer.cornerRadius = bounds.height/2
    }

}
