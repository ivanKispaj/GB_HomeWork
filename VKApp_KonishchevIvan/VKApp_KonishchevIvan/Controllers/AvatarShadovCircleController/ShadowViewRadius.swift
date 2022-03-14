//
//  Customise.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.03.2022.
//

import UIKit

class ShadowViewRadius: UIView {

    var shadowColor: CGColor = UIColor(named: "AvatarShadow")!.cgColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = bounds.height/2
    }
}

