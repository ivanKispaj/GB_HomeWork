//
//  extension_UIImageView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 19.02.2022.
//

import UIKit

extension UIImageView {
    func makeCircle(){
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
