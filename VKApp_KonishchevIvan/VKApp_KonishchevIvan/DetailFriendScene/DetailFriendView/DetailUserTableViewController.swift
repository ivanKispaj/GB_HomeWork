//
//  DetailUserTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//


import UIKit

class DetailUserTableViewController: UITableViewController, TableViewDelegate {
 
// Данные пользователя которого выбрали на предыдущем контроллере (FriendsTableViewController)
    var friendsSelectedd: Friend!
    var activityIndicator: UIActivityIndicatorView!
   // var detailsControllerData: DetailsControllerData!
    
    
    var frameImages: [CGRect]?
    var currentFrameImages: CGRect?
    var collectionFrame: CGRect?
    var currentImage: Int?
  
    // переменная для следующего контроллера
    var nextViewData: [ImageAndLikeData] = []
    // данные для отображения секций таблицы
    var dataTable: [UserDetailsTableData]! {
        didSet {
            DispatchQueue.main.async {
    // перезагружаем таблицу после получения данных
                         self.tableView.reloadData()
            }
        }
    }

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
 //  подгружаем данные пользователя
        self.loadDataTable()
        setHeaderDetailView()
        tableView.register(UINib(nibName: "CouruselTableViewCell", bundle: nil), forCellReuseIdentifier: "CouruselCellForDetails")
        tableView.register(UINib(nibName: "GallaryTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryTableCell")
        tableView.register(UINib(nibName: "SinglePhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleTableCellID")
        tableView.register(UINib(nibName: "LinkTableViewCell", bundle: nil), forCellReuseIdentifier: "LinkTableViewCell")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let data = self.dataTable {
            return data.count
            
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // установка имени секции
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Друзья"
        case 1:
            return "Фотографии"
       
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataTable[indexPath.section].sectionType {
        case .Friends:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CouruselCellForDetails", for: indexPath) as? CouruselTableViewCell else {
                preconditionFailure("Error")
            }
            let data = dataTable![indexPath.section].sectionData
            cell.collectionData = data.friends
         //   cell.collectionData = self.hisFriends
            cell.delegate = self
            return cell
        case .Gallary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GallaryTableCell", for: indexPath) as? GallaryTableViewCell else {
                preconditionFailure("Error")
            }
            let data = dataTable![indexPath.section].sectionData
            if let photo = data.photo {
                    cell.gallaryData = photo
                cell.countCell = 0
            }
            cell.delegate = self
            cell.delegateFrameImages = self
            return cell
        case .SingleFoto:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTableCellID", for: indexPath) as? SinglePhotoTableViewCell else {
                preconditionFailure("Error")
            }
           
            let data = dataTable[indexPath.section].sectionData
            cell.singleLableUserName.text = self.friendsSelectedd.userName
            cell.singleAvatarHeader.loadImageFromUrlString(self.friendsSelectedd.photo)
            cell.likeControll.delegate = self
            cell.likeControll.indexPath = indexPath
            let seen: String = String((data.views?.count)!)
            cell.singlePhotoSeenCount.text = seen
            cell.delegate = self
            cell.singlePhoto = data.photo![indexPath.row]
            cell.singlPhotoLikeLable.text = String(data.likes.count)
            cell.singlePhotoSeenCount.text = String(data.views!.count)
            return cell
//        case .newsText:
//            print(" Текст новость со стены")
//        case .video:
//            print( "Video news from wall")
        case .link:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as? LinkTableViewCell else {
                preconditionFailure("Error")
            }
            let data = dataTable[indexPath.section].sectionData
            cell.linkCaption.text = data.captionNews
            cell.linkDate.text = unixTimeConvertion(unixTime: Double(data.date))
            cell.linkLink.setTitle(data.linkUrl, for: .normal)
            cell.linkLikeCount.text = String(data.likes.count)
            cell.linkUserLogo.loadImageFromUrlString(self.friendsSelectedd.photo)
            cell.linkUserName.text = self.friendsSelectedd.userName
            cell.linkText.text = data.titleNews
            cell.linkSeenCount.text = String(data.views!.count)
            return cell
            
         default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTableCellID", for: indexPath) as? SinglePhotoTableViewCell else {
                preconditionFailure("Error")
            }
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
        let data = self.dataTable![indexPath.section].sectionData
        var likeStatus: Bool = false
        let countLike = data.likes.count
        if data.likes.userLike == 1 {
           likeStatus = true
        }
        return  [ countLike: likeStatus]
        
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.dataTable![indexPath.section].sectionData.likes.count = countLike
        if likeStatus {
            self.dataTable![indexPath.section].sectionData.likes.userLike = 1
        }else {
            self.dataTable![indexPath.section].sectionData.likes.userLike = 0
        }
    
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


