//
//  chekingValidityUrl.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.04.2022.
//

import UIKit
//MARK: - проверка соответствует ли строка URL

extension String {
    func isUrlString() -> Bool {
            if let url = NSURL(string: self) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        return false
    }
}
