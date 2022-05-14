//
//  NewGroupActivitiIndicator.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.05.2022.
//

import UIKit

extension NewGroupTableViewController {
func getActivityIndicatorLoadData() {
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    activityIndicator.color = UIColor.cyan
    activityIndicator.isHidden = true
    activityIndicator.style = .large
    activityIndicator.contentMode = .scaleToFill
    self.view.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    self.activityIndicator = activityIndicator
    NSLayoutConstraint.activate([
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
    ])
}
}
