//
//  ShadowCouruselAvatar.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit

class ShadowCouruselAvatar: UIView {

    var shadowColor: CGColor = UIColor(named: "AvatarShadow")!.cgColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
    }
    
    override func layoutSubviews() {
    }

}
