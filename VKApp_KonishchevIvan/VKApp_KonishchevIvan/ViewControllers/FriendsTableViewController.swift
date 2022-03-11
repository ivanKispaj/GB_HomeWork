//
//  FriendsTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//



import UIKit

class FriendsTableViewController: UITableViewController {

    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    struct DataSection {
        var header: String = ""
        var row: [Friends] = []
        init(header: String, row: [Friends]){
            self.header = header
            self.row = row
        }
    }
    
    let posibleFriends = DataSection(header: "Возможные друзья", row: [Friends(character: nil, image: UIImage.init(named: "AppIcon"), name: "Group VK.com", hisFriends: [])])
    
    var indexTitle: [String] = []
    
    var friends: [DataSection] = [] // будущий массив по буквам
    
    // Исходный массив друзей
    var friendsAlphavite = DataController.shared.getDataUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        tableView.register(UINib(nibName: "ExtendTableUserCell", bundle: nil), forCellReuseIdentifier: "ExtendCellXib")
        setDataSectionTable()
        

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
            cell.ExtendImageCell.image = friends[indexPath.section].row[indexPath.row].avatar
            cell.ExtendLabelCity.text = "Moscow"
            cell.ExtendLabelName.text = friends[indexPath.section].row[indexPath.row].name
            cell.isSelected = false
            return cell
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("FriendsCell cannot")
        }
            cell.labelCityCellXib.text = friends[indexPath.section].row[indexPath.row].city
        cell.imageCellAvatar.image = friends[indexPath.section].row[indexPath.row].avatar
        cell.lableCellXib.text = friends[indexPath.section].row[indexPath.row].name
        
            return cell
        }
        
    }

// Действия при выборе ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sampleStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailVC = sampleStoryboard.instantiateViewController(withIdentifier: "DetailUserTableView") as? DetailUserTableViewController else {
            return
        }
        let friend = friends[indexPath.section].row[indexPath.row].name
        let avatar = friends[indexPath.section].row[indexPath.row].avatar
        detailVC.title = friend
        detailVC.hisFriewnds = friends[indexPath.section].row[indexPath.row].hisFriends
        detailVC.detailUsername = friend
        detailVC.detailAvatar = avatar
        detailVC.detailUserInfo = friends[indexPath.section].row[indexPath.row].details
        detailVC.detailUserVisitInfo = "Был 1 час назад"
        
        self.navigationController?.show(detailVC, sender: nil)
       
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        headerView.backgroundColor = UIColor(named: "sectionColor")
        let headerLable = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 28))
        headerLable.textColor = UIColor.black
        headerLable.text = friends[section].header
        headerLable.textAlignment = .left
        headerView.addSubview(headerLable)
        let button = UIButton(frame: CGRect(x: headerView.frame.maxX - 150, y: 0, width: 150, height: 28))
        button.layer.cornerRadius = 5
        button.setTitle("Показать все", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.blue, for: .normal)
        // button.addTarget(se, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        headerView.addSubview(button)
        return headerView
    }



}


