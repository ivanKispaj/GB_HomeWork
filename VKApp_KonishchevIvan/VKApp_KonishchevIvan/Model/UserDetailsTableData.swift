//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

enum SectionType {
    case Friends
    case Gallary
    case SingleFoto
}

struct UserDetailsTableData {
    let sectionName: String
    let sectionType: SectionType
    
}
