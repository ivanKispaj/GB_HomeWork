//
//  DetailUserTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit

class DetailUserTableViewController: UITableViewController {

    var dataTable: [UserDetailsTableData] = []
    var detailAvatar: UIImage? = nil
    var detailUsername: String? = nil
    var detailUserInfo: String? = nil
    var detailUserVisitInfo: String? = nil
    var hisFriends: [HisFirends]? = nil
    let photo = GallaryPhoto(photo: [
        0: [UIImage(named: "onePhoto")!, UIImage(named: "twoPhoto")!],
        1: [UIImage(named: "threePhoto")!, UIImage(named: "fourPhoto")!]
        
    ])
    
    @IBOutlet weak var detailAvatarHeader: UIImageView!
    @IBOutlet weak var detailUserNameLable: UILabel!
    @IBOutlet weak var detailUserInfoLable: UILabel!
    @IBOutlet weak var detailUserAccountLable: UILabel!
    @IBOutlet weak var detailButtonMessage: UIButton!
    @IBOutlet weak var detailButtonCall: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderDetailView()
          
        dataTable.append(UserDetailsTableData(sectionName: "Friends", sectionType: .Friends ))
        dataTable.append(UserDetailsTableData(sectionName: "Gallary", sectionType: .Gallary))

        tableView.register(UINib(nibName: "CouruselTableViewCell", bundle: nil), forCellReuseIdentifier: "CouruselCellForDetails")
        tableView.register(UINib(nibName: "GallaryTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryTableCell")
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return dataTable.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    // установка имени секции
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
        return dataTable[section].sectionName

        }


    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataTable[indexPath.section].sectionType {
        case .Friends:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CouruselCellForDetails", for: indexPath) as? CouruselTableViewCell else {
                preconditionFailure("Error")
            }
            cell.collectionData = hisFriends
            return cell
        case .Gallary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GallaryTableCell", for: indexPath) as? GallaryTableViewCell else {
                preconditionFailure("Error")
            }
            cell.gallaryData = photo
            return cell
            
        }
    }

}
