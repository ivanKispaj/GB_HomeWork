//
//  FriendsTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//



import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var notifiToken: NotificationToken?
    let  realmService = RealmService()
    
    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    @IBOutlet weak var headerTableView: UIView!
    @IBOutlet weak var headerSubview: UIView!
    var activityIndicator: UIActivityIndicatorView!
    struct DataSection {
        var header: String = ""
        var row: [Friend] = []
        init(header: String, row: [Friend]){
            self.header = header
            self.row = row
        }
    }
    
    var posibleFriends: DataSection!
    var friends: [DataSection] = [] // будущий массив по буквам
    
    // Исходный массив друзей

    var friendsArray: [Friend] = []{
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
        self.setNotificationtoken()
        self.searchBar!.delegate = self
        registerCell()
        
        tableView.register(CustomHeaderoCell.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMyFriends()
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
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return friends[section].header
//    }

// Отрисовка ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let data = friends[indexPath.section].row[indexPath.row]
        let section = friends[indexPath.section].header
      
        if section == "Возможные друзья" {
            let cell: ExtendTableUserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setCelldata(from: data)
            return cell

        } else {
            let cell: SimpleTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setCellData(toFriendsScene: data)
         
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
            detailVC.friendsSelected = friendSelected
        }
    }

    //кастомный Header ячеек
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderCell") as! CustomHeaderoCell
        
        let sectionsName = friends[section].header
        view.nameSection.text = sectionsName

        if sectionsName == "Возможные друзья" {
            
            view.countFriends.text = " "
            view.action.text = "Показать все"
            
            
            return view
        }else {
            let friendCount = self.friendsArray.first?.countFriends ?? 0
            view.countFriends.text = String(friendCount) 
            view.action.text = "Списки"
            return view
        }
    } 
    //подготовка сегуе перехода. Срабатывает перед вызовом didSelectRowAt
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailUserTableViewController else { return
        }
        self.nextViewData = detailVC
    }
    
    private func registerCell() {
        tableView.register(SimpleTableCell.self)
        tableView.register(ExtendTableUserCell.self)
    }
}



