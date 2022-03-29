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
    // Ширина кнопки
    var buttonWidh: CGFloat?
 
    override func awakeFromNib() {
        super.awakeFromNib()

// Устанавливаем радиус кнопке, ее title и размер в соответствии с длинной title
        self.buttonSearchBar.layer.cornerRadius = 5
        self.buttonSearchBar.setTitle("Отмена", for: .normal)
        self.buttonSearchBar.sizeToFit()
        self.buttonWidh = self.buttonSearchBar.frame.size.width
// устанавливаем экшен на кнопку
        self.buttonSearchBar.addTarget(self, action: #selector(self.tapCancelButtonSearch), for: UIControl.Event.touchUpInside)

        self.searchBarStyle = .minimal
        
// удаляем родную лупу!
        let image = UIImage()
        self.setImage(image, for: UISearchBar.Icon.search, state: UIControl.State.normal)
        self.addSubview(buttonSearchBar)
    }
    
//MARK: - Функция делает анимацию смещения лупы и появления кнопки!
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
                self.buttonWidthConstraint.constant = self.buttonWidh!
                
                self.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.placeholder = "Search"
        }
        self.setPositionAdjustment(UIOffset(horizontal: 20, vertical: 0), for: UISearchBar.Icon.search)
    }
 //MARK: - Функция срабатывает при нажатии на кнопку отмены и возвращает лупу в центр а кнопку убирает
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




