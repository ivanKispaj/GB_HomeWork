//
//  MyGroupsTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 19.02.2022.
//

import UIKit

class MyGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var myGrouplable: UILabel!
    @IBOutlet weak var myGroupLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
