//
//  FriendsTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//



import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    @IBOutlet weak var headerTableView: UIView!
    @IBOutlet weak var headerSubview: UIView!
    var activityIndicator: UIActivityIndicatorView!
    struct DataSection {
        var header: String = ""
        var row: [FriendArray] = []
        init(header: String, row: [FriendArray]){
            self.header = header
            self.row = row
        }
    }
    var posibleFriends: DataSection!
    var friends: [DataSection] = [] // будущий массив по буквам
    
    // Исходный массив друзей

    var friendsArray: [FriendArray] = []{
        didSet {
                self.setDataSectionTable()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var nextViewData: DetailUserTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getActivityIndicatorLoadData()
       
            self.loadMyFriends()
        
            let dataVKPhoto =  "https://avatars.mds.yandex.net/get-zen_doc/1535103/pub_5f2dbed8c1a7b87558486d42_5f2dc071d1ab9668ff0d0ad8/scale_1200"
            self.posibleFriends = DataSection(header: "Возможные друзья", row: [FriendArray(userName: "VKGroup", photo: dataVKPhoto , id: 1, city: "Moscow", lastSeenDate: 12746822, isClosedProfile: false, isBanned: false, online: true, status: "Официальная группа VK")])
  
        self.searchBar!.delegate = self
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        tableView.register(UINib(nibName: "ExtendTableUserCell", bundle: nil), forCellReuseIdentifier: "ExtendCellXib")
        
        print(self.friends)

    }
    
    //MARK: - SearchBar Method
        // SearchBar FirstResponder
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            self.searchBar.tapInSearchBar()
            return true
        }
    

    // MARK: - Table view data source
    
// количество секций с одной буквой
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friends.count
    }
    
// количество строк таблици в одной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends[section].row.count
    }

// установка имени секции
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friends[section].header
    }

// Отрисовка ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = friends[indexPath.section].header
        if section == "Возможные друзья" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExtendCellXib", for: indexPath) as? ExtendTableUserCell else {
                preconditionFailure("FriendsCell cannot")
            }
            cell.ExtendImageCell.loadImageFromUrlString(self.friends[indexPath.section].row[indexPath.row].photo)
            cell.ExtendLabelCity.text = self.friends[indexPath.section].row[indexPath.row].city
            cell.ExtendLabelName.text = self.friends[indexPath.section].row[indexPath.row].userName
            cell.isSelected = false
            return cell

        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("FriendsCell cannot")
        }
            cell.imageCellAvatar.loadImageFromUrlString(self.friends[indexPath.section].row[indexPath.row].photo)
            cell.labelCityCellXib.text = friends[indexPath.section].row[indexPath.row].city
            cell.lableCellXib.text = friends[indexPath.section].row[indexPath.row].userName

            return cell
        }
        
    }

// Действия при выборе ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendSelected = friends[indexPath.section].row[indexPath.row]
        

        if  friendSelected.isBanned  {
            let allert = AllertWrongUserData().getAllert(title: "Сообщение", message: "Пользователь забанен")
            present(allert, animated: true)
        }else if friendSelected.isClosedProfile {
            let allert = AllertWrongUserData().getAllert(title: "Сообщение", message: "Профиль пользователя скрыт!")
            present(allert, animated: true)
        }else {
            performSegue(withIdentifier: "detailsUserSegueId", sender: nil)
            guard let detailVC = self.nextViewData else { return }

            detailVC.title = friendSelected.userName

            detailVC.friendsSelectedd = friendSelected
        }
    }

    //кастомный Header ячеек
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionsName = friends[section].header
        if sectionsName == "Возможные друзья" {
            let headerView = getHeaderView(size: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35), sectionName: sectionsName, buttonTitle: "Показать все", buttonWidth: 150)
            return headerView
        }else {
            let headerView = getHeaderView(size: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35), sectionName: sectionsName, buttonTitle: "Списки", buttonWidth: 150)
            return headerView
        }
    } 
 //подготовка сегуе перехода. Срабатывает перед вызовом didSelectRowAt
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailUserTableViewController else { return
        }
        self.nextViewData = detailVC
    }
    

    private func loadImageFromData(_ url: String, cellUIImageView: UIImageView) -> () {
        let url = URL(string: url)!
      
        DispatchQueue.global(qos: .userInitiated).async {
            let content = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = content {
                    cellUIImageView.image = UIImage(data: imageData)
                }
            }
        }
    }

}



