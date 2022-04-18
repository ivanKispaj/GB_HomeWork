//
//  chekingValidityUrl.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.04.2022.
//

import UIKit
//MARK: - проверка соответствует ли строка ajhvfne URL
func checkingValidityUrl(_ urlCheck: String?) -> Bool {
    if let urlCheck = urlCheck {
        if let url = NSURL(string: urlCheck) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}
