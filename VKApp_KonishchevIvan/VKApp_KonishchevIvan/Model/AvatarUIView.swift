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
    
    
    // @IBInspectable var shadowColor: CGColor = UIColor(named: "AvatarShadow")!.cgColor
     @IBInspectable var shadowColor: UIColor = .red
     @IBInspectable var radius: CGFloat {
         get {
             return self.layer.cornerRadius
         }
         set {
             self.layer.cornerRadius = newValue
         }
         
     }
     @IBInspectable var offset: CGSize  {
         get {
             return self.layer.shadowOffset
         }
         set{
             self.layer.shadowOffset = newValue
         }
     }
     @IBInspectable var shadowOpaciti: Float {
         get {
             return self.layer.shadowOpacity
         }
         set {
             self.layer.shadowOpacity = newValue
         }
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowViewCell.layer.shadowColor = shadowColor.cgColor
        shadowViewCell.layer.shadowOffset = offset
        shadowViewCell.layer.shadowRadius = radius
        shadowViewCell.layer.shadowOpacity = shadowOpaciti
    }
    override func layoutSubviews() {
        circleViewImage.layer.cornerRadius = bounds.height/2
        shadowViewCell.layer.cornerRadius = bounds.height/2
        self.layer.cornerRadius = bounds.height/2
    }

}
