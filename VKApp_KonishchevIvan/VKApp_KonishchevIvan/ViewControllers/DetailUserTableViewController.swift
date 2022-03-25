//
//  DetailUserTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//


import UIKit

class DetailUserTableViewController: UITableViewController, TableViewDelegate {
   
    
    var nextViewData: [ImageAndLikeData] = []
    

    var dataTable: [UserDetailsTableData] = []
    var detailAvatar: UIImage? = nil
    var detailUsername: String? = nil
    var detailUserInfo: String? = nil
    var detailUserVisitInfo: String? = nil
    var hisFriends: [HisFirends]? = nil
    let photo:[ImageAndLikeData] = DataController.shared.getPhoto()

    
    @IBOutlet weak var detailAvatarHeader: UIImageView!
    @IBOutlet weak var detailUserNameLable: UILabel!
    @IBOutlet weak var detailUserInfoLable: UILabel!
    @IBOutlet weak var detailUserAccountLable: UILabel!
    @IBOutlet weak var detailButtonMessage: UIButton!
    @IBOutlet weak var detailButtonCall: UIButton!
    
    var isLikeStatus: Bool = false
    var likeCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderDetailView()
        
        dataTable.append(UserDetailsTableData(sectionName: "Friends", sectionType: .Friends ))
        dataTable.append(UserDetailsTableData(sectionName: "Gallary", sectionType: .Gallary))
        dataTable.append(UserDetailsTableData(sectionName: "", sectionType: .SingleFoto))
        
        tableView.register(UINib(nibName: "CouruselTableViewCell", bundle: nil), forCellReuseIdentifier: "CouruselCellForDetails")
        tableView.register(UINib(nibName: "GallaryTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryTableCell")
        tableView.register(UINib(nibName: "SinglePhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleTableCellID")
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
            cell.delegate = self
            return cell
        case .Gallary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GallaryTableCell", for: indexPath) as? GallaryTableViewCell else {
                preconditionFailure("Error")
            }
            cell.gallaryData = photo
            cell.delegate = self
            return cell
        case .SingleFoto:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTableCellID", for: indexPath) as? SinglePhotoTableViewCell else {
                preconditionFailure("Error")
            }
            cell.singleLableUserName.text = detailUsername
            cell.singleAvatarHeader.image = detailAvatar
            if self.isLikeStatus {
                cell.singlePhotoLikeImage.image = UIImage(systemName: "suit.heart.fill")
                cell.singlePhotoLikeImage.tintColor = UIColor.red
                cell.singlPhotoLikeLable.text = String(self.likeCount)
                self.isLikeStatus = cell.isLikeStatus
            }else {
                cell.singlePhotoLikeImage.image = UIImage(systemName: "suit.heart")
                cell.singlePhotoLikeImage.tintColor = UIColor.systemGray2
                cell.singlPhotoLikeLable.text = String(self.likeCount)
                self.isLikeStatus = cell.isLikeStatus
            }
            cell.delegate = self
            return cell
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destionationVC = segue.destination as? PhotoGallaryPressetViewController else {
            preconditionFailure("Error")
        }
        destionationVC.dataCollection = self.nextViewData
    }

    func selectRow(nextViewData: [ImageAndLikeData]) {
        self.nextViewData = nextViewData
        performSegue(withIdentifier: "DetailFriendsPreviewID", sender: nil)
    }
}


