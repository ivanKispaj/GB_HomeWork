//
//  LoadImageFromUrlString.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

extension UIImageView {
    func loadImageFromUrlString(_ url: String?)  {
             guard let urlImage = url, urlImage != "" else { return }
            let url = URL(string: urlImage)!
            // DispatchQueue.global(qos: .userInteractive).async {
                let content = try? Data(contentsOf: url)
               DispatchQueue.main.async {
                    if let imageData = content {
                            self.image = UIImage(data: imageData)
                     
                    }else {
                        self.image = UIImage(named: "noFoto")
                    }
                }
           // }
        }
}
