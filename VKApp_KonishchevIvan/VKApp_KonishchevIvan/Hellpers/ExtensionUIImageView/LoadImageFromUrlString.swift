//
//  LoadImageFromUrlString.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

extension UIImageView {
    func loadImageFromUrlString(_ url: String, placeholder: UIImage? = UIImage(named: "noFoto")) {
        self.image = nil

        let imageServerUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeholder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadImage = UIImage(data: data) {
                            self.image = downloadImage
                        }
                    }
                }
            }.resume()
        }
    }
}
