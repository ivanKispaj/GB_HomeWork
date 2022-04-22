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
    
//MARK: - Bizzer start

    // Color Declarations
    let color = UIColor(red: 0.315, green: 0.684, blue: 0.764, alpha: 1.000)
    let color2 = UIColor(red: 0.730, green: 0.902, blue: 0.950, alpha: 1.000)
    let shadowColor = UIColor(red: 0.000, green: 0.458, blue: 1.000, alpha: 1.000)


    //// Bezier Drawing
    let cloudBizerPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 32, y: 84))
        bezierPath.addCurve(to: CGPoint(x: 15, y: 87), controlPoint1: CGPoint(x: 32, y: 84), controlPoint2: CGPoint(x: 26, y: 90))
        bezierPath.addCurve(to: CGPoint(x: 3, y: 71), controlPoint1: CGPoint(x: 4, y: 84), controlPoint2: CGPoint(x: 3, y: 71))
        bezierPath.addCurve(to: CGPoint(x: 9, y: 58), controlPoint1: CGPoint(x: 3, y: 71), controlPoint2: CGPoint(x: 3, y: 63))
        bezierPath.addCurve(to: CGPoint(x: 19, y: 54), controlPoint1: CGPoint(x: 15, y: 53), controlPoint2: CGPoint(x: 19, y: 54))
        bezierPath.addCurve(to: CGPoint(x: 27, y: 37), controlPoint1: CGPoint(x: 19, y: 54), controlPoint2: CGPoint(x: 15, y: 47))
        bezierPath.addCurve(to: CGPoint(x: 45, y: 34), controlPoint1: CGPoint(x: 39, y: 27), controlPoint2: CGPoint(x: 45, y: 34))
        bezierPath.addCurve(to: CGPoint(x: 62, y: 20), controlPoint1: CGPoint(x: 45, y: 34), controlPoint2: CGPoint(x: 45, y: 20))
        bezierPath.addCurve(to: CGPoint(x: 74, y: 20), controlPoint1: CGPoint(x: 79, y: 20), controlPoint2: CGPoint(x: 74, y: 20))
        bezierPath.addCurve(to: CGPoint(x: 90, y: 31), controlPoint1: CGPoint(x: 74, y: 20), controlPoint2: CGPoint(x: 86, y: 20))
        bezierPath.addCurve(to: CGPoint(x: 93, y: 44), controlPoint1: CGPoint(x: 94, y: 42), controlPoint2: CGPoint(x: 93, y: 44))
        bezierPath.addCurve(to: CGPoint(x: 111, y: 54), controlPoint1: CGPoint(x: 93, y: 44), controlPoint2: CGPoint(x: 104, y: 37))
        bezierPath.addCurve(to: CGPoint(x: 103, y: 84), controlPoint1: CGPoint(x: 118, y: 71), controlPoint2: CGPoint(x: 103, y: 84))
        bezierPath.addCurve(to: CGPoint(x: 93, y: 87), controlPoint1: CGPoint(x: 103, y: 84), controlPoint2: CGPoint(x: 100, y: 87))
        bezierPath.addCurve(to: CGPoint(x: 86, y: 84), controlPoint1: CGPoint(x: 86, y: 87), controlPoint2: CGPoint(x: 86, y: 84))
        bezierPath.addCurve(to: CGPoint(x: 74, y: 94), controlPoint1: CGPoint(x: 86, y: 84), controlPoint2: CGPoint(x: 86, y: 91))
        bezierPath.addCurve(to: CGPoint(x: 56, y: 87), controlPoint1: CGPoint(x: 62, y: 97), controlPoint2: CGPoint(x: 56, y: 87))
        bezierPath.addCurve(to: CGPoint(x: 45, y: 91), controlPoint1: CGPoint(x: 56, y: 87), controlPoint2: CGPoint(x: 48, y: 95))
        bezierPath.addCurve(to: CGPoint(x: 32, y: 84), controlPoint1: CGPoint(x: 42, y: 87), controlPoint2: CGPoint(x: 32, y: 84))
        return bezierPath
    }()

    
//MARK: - Bizzer end
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let layer = CAShapeLayer()
        layer.path = cloudBizerPath.cgPath
        layer.lineWidth = 6
        layer.strokeColor = color.cgColor
        layer.fillColor =  color2.cgColor
        
        layer.strokeEnd = 1
        layer.strokeStart = 0
    
        layer.frame.origin.x = -20
        self.layer.addSublayer(layer)
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
    
        strokeEndAnimation.fromValue = 1
        strokeEndAnimation.toValue = 0.5
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.98, 0.2, 0, 0.88)
        
        let strokeStartAnumation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnumation.fromValue = 0
        strokeStartAnumation.toValue = 0.2
        strokeStartAnumation.timingFunction = CAMediaTimingFunction(controlPoints: 0.31,0.95,0.24,0.01)
        
        let strokeCurrentAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeCurrentAnimation.fromValue = 0
        strokeCurrentAnimation.toValue = 1
        strokeCurrentAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.1,0.85,0.24,0.01)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [ strokeEndAnimation, strokeStartAnumation, strokeCurrentAnimation]
        layer.add(animationGroup, forKey: nil)
        
        let circleLayer = CAShapeLayer()
        circleLayer.backgroundColor = color2.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 6 , height: 6)
        circleLayer.cornerRadius = 3
       
        self.layer.addSublayer(circleLayer)
       

        let followanim = CAKeyframeAnimation(keyPath: #keyPath(CAScrollLayer.position))
        followanim.path = cloudBizerPath.cgPath
        followanim.calculationMode = .paced
        followanim.duration = 3
        followanim.repeatCount = .infinity
        circleLayer.add(followanim, forKey: nil)

    }
    
}
