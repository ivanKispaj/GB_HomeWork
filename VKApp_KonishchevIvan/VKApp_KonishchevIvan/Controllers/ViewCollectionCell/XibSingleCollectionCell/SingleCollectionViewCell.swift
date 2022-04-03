//
//  SingleCollectionViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class SingleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var singlePhoto: UIImageView!
    var delegate: PhotoGallaryPressetViewController!
    private var animateImage = UIViewPropertyAnimator()
    override func awakeFromNib() {
        super.awakeFromNib()
          
        //let swipe = UIPanGestureRecognizer(target: self, action: #selector(leftSwipeImageCollection))
     //   self.addGestureRecognizer(swipe)
    }

}


extension SingleCollectionViewCell {
    
//    @objc func leftSwipeImageCollection(_ pen: UIPanGestureRecognizer) {
//        if pen.translation(in: self.singlePhoto).x < 0 {
//            self.singlePhoto.frame.origin.x = self.singlePhoto.frame.origin.x - 1
//        }else {
//            self.singlePhoto.frame.origin.x = self.singlePhoto.frame.origin.x + 1
//        }
//        
//    }
//        let locationX = pen.location(in: self).x
//        let directionX = pen.translation(in: self).x
//        var transitionX: CGFloat = 0
//        if directionX < 0 {
//            transitionX = CGFloat(0 - self.singlePhoto.frame.width)
//        }else {
//            transitionX = CGFloat( 0 + self.singlePhoto.frame.width)
//        }
//        switch pen.state {
//        case .began:
//            animateImage = UIViewPropertyAnimator(duration: 0.6, curve: .linear , animations: {
//                self.singlePhoto.transform = CGAffineTransform(translationX: transitionX, y: self.singlePhoto.frame.origin.y)
//
//            })
//            animateImage.addCompletion { position in
//                switch position {
//                case .end:
//                  print("end")
//                case .start:
//                    print("start")
//                case .current:
//                    print("current")
//                @unknown default:
//                    print("XER")
//                }
//            }
//
//        case .changed:
//            var percent = pen.translation(in: self.singlePhoto).x / 200
//            if percent < 0 {
//                percent.negate()
//            }
//
//
//            animateImage.fractionComplete =  min(1, max(0, percent))
//
//        case .ended:
//
//            if animateImage.fractionComplete > 0.5 {
//                animateImage.continueAnimation(withTimingParameters: nil, durationFactor:  0.3)
//            }else {
//                animateImage.isReversed = true
//                animateImage.continueAnimation(withTimingParameters: nil, durationFactor: 0.3)
//            }
//        default:
//            print("ХЗ")
//        }


    }
    

