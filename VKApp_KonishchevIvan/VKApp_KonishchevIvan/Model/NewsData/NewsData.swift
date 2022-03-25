//
//  NewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
enum CellType {
    case textWithimage
    case textWithTextView
    
}
struct NewsData {
    let cellType: CellType
    let newsText: String?
    let newsImage: ImageAndLikeData?
}
