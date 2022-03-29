//
//  LoadingView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 27.03.2022.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var firstCircle: UIImageView!
    @IBOutlet weak var twoCircle: UIImageView!
    @IBOutlet weak var threeCircle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat,.autoreverse]) {
            self.firstCircle.alpha = 0
        }
        UIView.animate(withDuration: 0.5, delay: 0.25, options: [.repeat,.autoreverse]) {
            self.twoCircle.alpha = 0
        }
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat,.autoreverse]) {
            self.threeCircle.alpha = 0
        }

//            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.repeat, .autoreverse], animations: {self.firstCircle.alpha = 0})
//            UIView.animate(withDuration: 0.4, delay: 0.3, options: [.repeat, .autoreverse], animations: {self.twoCircle.alpha = 0})
//            UIView.animate(withDuration: 0.4, delay: 0.6, options: [.repeat, .autoreverse], animations: {self.threeCircle.alpha = 0})
//
    }
}
