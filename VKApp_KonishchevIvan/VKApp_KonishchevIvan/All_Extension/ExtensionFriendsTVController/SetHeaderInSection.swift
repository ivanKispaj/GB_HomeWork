//
//  SetHeaderInSection.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.03.2022.
//

import UIKit

extension FriendsTableViewController {
    
    func getHeaderView(size: CGRect, sectionName: String, buttonTitle: String, buttonWidth: Int) -> UIView {
        let headerView = UIView(frame: size)
        let headerLabel = UILabel(frame: CGRect(x: 20, y: -10, width: 180, height: 30))
        headerLabel.textColor = UIColor(named: "AppBW")
        headerLabel.text = sectionName
        headerLabel.textAlignment = .left
        headerView.addSubview(headerLabel)
        let headerButton = UIButton(frame: CGRect(x: Int(headerView.frame.maxX) - 150, y: -10, width: buttonWidth, height: 30))
        headerButton.setTitle(buttonTitle, for: .normal)
        headerButton.setTitleColor(UIColor(named: "AppButton"), for: .normal)
        headerView.addSubview(headerButton)
        
        return headerView
    }

}
