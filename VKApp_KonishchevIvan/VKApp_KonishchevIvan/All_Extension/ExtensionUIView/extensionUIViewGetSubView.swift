//
//  extensionUIViewGetSubView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.03.2022.
//

import UIKit


extension UIView {
    func subViews<T: UIView>(type : T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }
    
    func allSubViewOf<T: UIView>(type: T.Type)-> [T] {
        var all = [T]()
        func getSubView(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else{ return }
            view.subviews.forEach{ getSubView(view: $0)}
            
        }
        getSubView(view: self)
        return all
    }

}
