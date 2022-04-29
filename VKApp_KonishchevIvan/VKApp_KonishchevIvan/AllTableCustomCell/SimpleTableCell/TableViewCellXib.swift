//
//  TableViewCellXib.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 05.03.2022.
//

import UIKit
// Макет ячейки с переменными для установки
class TableViewCellXib: UITableViewCell {

    @IBOutlet weak var profileStatus: UILabel!
    @IBOutlet weak var imageCellAvatar: UIImageView!
    @IBOutlet weak var lableCellXib: UILabel!
    @IBOutlet weak var labelCityCellXib: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
