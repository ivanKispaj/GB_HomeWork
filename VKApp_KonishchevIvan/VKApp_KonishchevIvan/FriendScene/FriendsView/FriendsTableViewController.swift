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
    
    struct DataSection {
        var header: String = ""
        var row: [FriendsItems] = []
        init(header: String, row: [FriendsItems]){
            self.header = header
            self.row = row
        }
    }
    
    let posibleFriends = DataSection(header: "Возможные друзья", row: [FriendsItems(photo50: "asd", city: City(id: 1, title: "Москва"), fName: "VKGroup", lName: "VKGroup", id: 100, online: 1,lastSeen: LastSeen(platform: 1, time: 1648837799), isClosedProfile: false, banned: "")])
    
    var friends: [DataSection] = [] // будущий массив по буквам
    
    // Исходный массив друзей
    var friendsAlphavite: [FriendsItems]!
    var nextViewData: DetailUserTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  //MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
        InternetConnections(host: "api.vk.com", path: "/method/friends.get").getListOfFirends(for: "72287677") { [weak self] response in
            switch response {
  // обработка ответа
            case .success(let result):               
                DispatchQueue.main.async {
                    self?.friendsAlphavite = result.response.items
                    self!.setDataSectionTable()
                    self!.tableView.reloadData()
                }
            case .failure(_):
                print("ErrorLoadDataVK")
            }
        }
        
        
        self.searchBar!.delegate = self
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        tableView.register(UINib(nibName: "ExtendTableUserCell", bundle: nil), forCellReuseIdentifier: "ExtendCellXib")
        
        

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
            let imgUrl = self.friends[indexPath.section].row[indexPath.row].photo50
            if imgUrl.isUrlString() {
                let url = URL(string: imgUrl)
                DispatchQueue.main.async {
                       let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                       cell.ExtendImageCell.image  = UIImage(data: data!)
                }
            }else {
                cell.ExtendImageCell.image = UIImage(named: "noFoto")
            }

            cell.ExtendLabelCity.text = friends[indexPath.section].row[indexPath.row].city?.title
            cell.ExtendLabelName.text = "\(friends[indexPath.section].row[indexPath.row].fName) \(friends[indexPath.section].row[indexPath.row].lName) "
            cell.isSelected = false
            return cell
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("FriendsCell cannot")
        }
            let imgUrl = self.friends[indexPath.section].row[indexPath.row].photo50
            if imgUrl.isUrlString() {
                let url = URL(string: imgUrl)
                DispatchQueue.main.async {
                       let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                       cell.imageCellAvatar.image  = UIImage(data: data!)
                }
            }else {
                cell.imageCellAvatar.image = UIImage(named: "noFoto")
            }
            cell.labelCityCellXib.text = friends[indexPath.section].row[indexPath.row].city?.title
            cell.lableCellXib.text = "\(friends[indexPath.section].row[indexPath.row].fName) \(friends[indexPath.section].row[indexPath.row].lName) "
        
            return cell
        }
        
    }

// Действия при выборе ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendSelected = friends[indexPath.section].row[indexPath.row]

        
        if  friendSelected.banned != nil {
            let allert = AllertWrongUserData().getAllert(title: "Сообщение", message: "Пользователь забанен")
            present(allert, animated: true)
        }else if friendSelected.isClosedProfile! {
            let allert = AllertWrongUserData().getAllert(title: "Сообщение", message: "Профиль пользователя скрыт!")
            present(allert, animated: true)
        }else {
            performSegue(withIdentifier: "detailsUserSegueId", sender: nil)
            guard let detailVC = self.nextViewData else { return }
            let friend = "\(friends[indexPath.section].row[indexPath.row].fName) \(friends[indexPath.section].row[indexPath.row].lName)"
            detailVC.title = friend
            
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
    


}



