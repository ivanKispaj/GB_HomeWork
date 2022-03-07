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
    
    let posibleFriends = DataSection(header: "Возможные друзья", row: [Friends(character: nil, image: UIImage.init(named: "AppIcon"), name: "Group VK.com")])
    var indexTitle: [String] = []
    
    var friends: [DataSection] = [] // будущий массив по буквам
    
    // Исходный массив друзей
    var friendsAlphavite = [
        Friends(image: UIImage.init(named: "Putin"), name: "Путин"),
        Friends(image: UIImage.init(named: "Bregnev"), name: "Брежнев"),
        Friends(image: UIImage.init(named: "FranclinRuzvelt"), name: "Франклин Рузвельт"),
        Friends(image: UIImage.init(named: "MaoCzydun"), name: "Мао Дзядун"),
        Friends(image: UIImage.init(named: "MargaretTetcher"), name: "Маргарет Тетчер"),
        Friends(image: UIImage.init(named: "Merkel"), name: "Меркель"),
        Friends(image: UIImage.init(named: "MohandasGandi"), name: "Мохандос Ганди"),
        Friends(image: UIImage.init(named: "Stalin"), name: "Сталин"),
        Friends(image: UIImage.init(named: "WinstonCherchil"), name: "Винстон Черчиль"),
    ]
    
    
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
        cell.imageCellAvatar.image = friends[indexPath.section].row[indexPath.row].avatar
        cell.lableCellXib.text = friends[indexPath.section].row[indexPath.row].name
        
            return cell
        }
        
    }

// Действия при выборе ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sampleStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailVC = sampleStoryboard.instantiateViewController(withIdentifier: "DetailsCollectionViewController") as? DetailsCollectionViewController else {
            return
        }
        let friend = friends[indexPath.section].row[indexPath.row].name
                   let avatar = friends[indexPath.section].row[indexPath.row].avatar
        detailVC.title = friend
        detailVC.name = friend
        detailVC.avatar = avatar
        self.navigationController?.show(detailVC, sender: nil)
       
    }
 
// Установка бокового буквенного поиска
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        tableView.sectionIndexColor = UIColor(named: "AppBW")
//        return indexTitle
//    }


}


