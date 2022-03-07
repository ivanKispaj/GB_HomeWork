//
//  ShadowViewXib.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 05.03.2022.
//

import UIKit

class ShadowViewXib: UIView {
    
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
