//
//  DetailUserTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//


import UIKit

class DetailUserTableViewController: UITableViewController, TableViewDelegate {
 
// Данные пользователя которого выбрали на предыдущем контроллере (FriendsTableViewController)
    var friendsSelectedd: FriendArray!
    var activityIndicator: UIActivityIndicatorView!
   // var detailsControllerData: DetailsControllerData!
    
    
    var frameImages: [CGRect]?
    var currentFrameImages: CGRect?
    var collectionFrame: CGRect?
    var currentImage: Int?
  
    // переменная для следующего контроллера
    var nextViewData: [ImageAndLikeData] = []
    // данные для отображения секций таблицы
    var dataTable: [UserDetailsTableData] = []
    // обновляет таблицу если и hisFriends и photo установленны!
    var dataUpdate: Bool = false {
        didSet {
            self.setTableSection()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   // массив с друзьями друга
    var hisFriends: [FriendArray]? {
        didSet {
            if self.photo != nil {
                self.dataUpdate = true
            }
        }
    }
    //массив с фото друга
    var photo:[ImageAndLikeData]? {
        didSet {
            if self.hisFriends != nil {
                self.dataUpdate = true
            }
        }
    }
    // одиночное изображение с лайками
    var singlePhoto: ImageAndLikeData?
    var currentImageTap: Int!
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

        self.LoadUserWall()
        getActivityIndicatorLoadData()
        self.loadFriendsSelectedUser()
        self.loadPhotoAlbumSelctedUser()
        setHeaderDetailView()
      

        
        
      
        tableView.register(UINib(nibName: "CouruselTableViewCell", bundle: nil), forCellReuseIdentifier: "CouruselCellForDetails")
        tableView.register(UINib(nibName: "GallaryTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryTableCell")
        tableView.register(UINib(nibName: "SinglePhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleTableCellID")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataTable.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            cell.collectionData = self.hisFriends
            cell.delegate = self
            return cell
        case .Gallary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GallaryTableCell", for: indexPath) as? GallaryTableViewCell else {
                preconditionFailure("Error")
            }
            if self.photo != nil{
                    cell.gallaryData = self.photo!
            }
            cell.delegate = self
            cell.delegateFrameImages = self
            return cell
        case .SingleFoto:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTableCellID", for: indexPath) as? SinglePhotoTableViewCell else {
                preconditionFailure("Error")
            }
            cell.singleLableUserName.text = self.friendsSelectedd.userName
            cell.singleAvatarHeader.loadImageFromUrlString(self.friendsSelectedd.photo)
            cell.likeControll.delegate = self
            cell.likeControll.indexPath = indexPath
            cell.delegate = self
            cell.singlePhoto = self.photo?.first
            self.singlePhoto = self.photo?.first
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let destinationVC = segue.destination as? GallaryViewController else {
            preconditionFailure("Error")
        }
     
        destinationVC.arrayPhoto = self.nextViewData
 
        destinationVC.title = "Фото галлерея"
        destinationVC.currentFrame = self.currentFrameImages
        destinationVC.frameArray = self.frameImages
        destinationVC.collectionViewFrame = collectionFrame
    }
    private func setTableSection() {
        if let friends = self.hisFriends?.count, friends > 0 {
            dataTable.append(UserDetailsTableData(sectionName: "Friends", sectionType: .Friends ))
        }
        if let photo = self.photo?.count, photo > 1 {
            dataTable.append(UserDetailsTableData(sectionName: "Gallary", sectionType: .Gallary))
            dataTable.append(UserDetailsTableData(sectionName: "Single Photo", sectionType: .SingleFoto))
        }else {
            dataTable.append(UserDetailsTableData(sectionName: "Single Photo", sectionType: .SingleFoto))
        }
    }

//MARK: - TableViewDelegate method
    func selectRow(nextViewData: [ImageAndLikeData]) {
        self.nextViewData = nextViewData
        let indexPath = IndexPath(row: 0, section: 1)
        var cellRect = self.tableView.rectForRow(at: indexPath) //Получаем область нужной ячейки
        let contentOffset = tableView.contentOffset //смещение контента таблицы относительно начального нулевого положения
        let y_coordinate = cellRect.origin.y - contentOffset.y //чистая y координата ячейки относительно экранных координат
        cellRect.origin.y = y_coordinate
        self.collectionFrame = cellRect
        
 //MARK: - Custom push imageGallary
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "GallaryVievController") as? GallaryViewController else { return }
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.transitioningDelegate = nextVC
            nextVC.collectionViewFrame = self.collectionFrame
            nextVC.currentFrame = self.currentFrameImages
            nextVC.frameArray = self.frameImages
            nextVC.arrayPhoto = nextViewData
            nextVC.title = "Фото галлерея"
            nextVC.currentImage = self.currentImage!
           self.present(nextVC, animated: true)
    }
}

// MARK: - методы для делегата like controll !!
extension DetailUserTableViewController: ProtocolLikeDelegate {

    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let countLike = singlePhoto?.likeLabel
        let likeStatus = singlePhoto?.likeStatus
        return  [ countLike!: likeStatus!]//[countLike: likeStatus]
        
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.singlePhoto?.likeStatus = likeStatus
        self.singlePhoto?.likeLabel = countLike
    
    }
    

}

//MARK: - delegate SetFrameImages
extension DetailUserTableViewController: SetFrameImages {
    func setFrameImages(_ frame: [CGRect], currentFrame: CGRect) {
        self.frameImages = frame
        self.currentFrameImages = currentFrame

    }

    func setCurrentImage(_ currentImage: Int) {
        self.currentImage = currentImage
    }

}


