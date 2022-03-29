//
//  CustomSearshBar.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 27.03.2022.
//

import UIKit

class CustomSearshBar: UISearchBar {
    @IBOutlet weak var searchLeadingConstaint: NSLayoutConstraint!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonSearchBar: UIButton!
    @IBOutlet weak var searchImage: UIImageView!
    var togleButton: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.buttonSearchBar.layer.cornerRadius = 5
        
        self.buttonSearchBar.addTarget(self, action: #selector(self.tapCancelButtonSearch), for: UIControl.Event.touchUpInside)

        searchImage.tintColor = UIColor.black
        searchImage.layer.opacity = 1
        self.searchBarStyle = .minimal
        
// удаляем родную лупу!
        let image = UIImage()
        self.setImage(image, for: UISearchBar.Icon.search, state: UIControl.State.normal)
        self.addSubview(buttonSearchBar)
    }
    

    
    func tapTheSearchBar() {
 
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut ) {
            self.searchLeadingConstaint.constant = 14
            self.layoutIfNeeded()
        }completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 0.2,
                           options: .curveEaseInOut ) {
                self.buttonWidthConstraint.constant = 80
                self.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.placeholder = "Search"
        }
        self.setPositionAdjustment(UIOffset(horizontal: 20, vertical: 0), for: UISearchBar.Icon.search)
    }
    
    @objc func tapCancelButtonSearch() {
 
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut ) {
            self.searchLeadingConstaint.constant = self.frame.width / 2
            self.layoutIfNeeded()
        }completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 0.2,
                           options: .curveEaseInOut ) {
                self.buttonWidthConstraint.constant = 0
                self.layoutIfNeeded()
            }
        }
        
        UIView.animate(withDuration: 0.5) {
           // self.searchImage.layer.position.x = 0
            self.placeholder = ""
        }
        self.text = ""
        self.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: UISearchBar.Icon.search)
        self.resignFirstResponder()
    }
}




