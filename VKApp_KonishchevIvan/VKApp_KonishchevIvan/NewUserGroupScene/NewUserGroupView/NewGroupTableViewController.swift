//
//  NewGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit
import WebKit

class NewGroupTableViewController: UITableViewController, UISearchBarDelegate {
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func NewSearchGroup(_ sender: Any) {
        setSearchFieldAllert()
        self.present(self.allert, animated: true)
        self.allert = nil
    }
    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    // аллерт для поиска групп
    var allert: UIAlertController!
    var userGroupDelegate: UserGroupTableViewDelegate? = nil
    var allGroups: [AllNewUserGroups] = []{
        didSet {
            if allGroups.count != 0 {
            self.allGroupSeacrch = allGroups
            self.allGroupDictionary = sort(group: allGroupSeacrch)
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
            }
        }
    }
    var allGroupSeacrch: [AllNewUserGroups] = []
    var chars: [String] = []
    var allGroupDictionary = [String: [AllNewUserGroups]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        getActivityIndicatorLoadData()
        
        self.searchBar.delegate = self
        self.allGroupSeacrch = self.allGroups

        self.allGroupDictionary = sort(group: allGroupSeacrch)
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        
    }
// MARK: - SearchBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
            setSearchFieldAllert()
            self.present(self.allert, animated: true)
    
        
       
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.allGroupDictionary.removeAll()
        self.allGroupSeacrch.removeAll()
        self.allGroups.removeAll()
        self.chars.removeAll()
            self.allert = nil
        self.tableView.reloadData()
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
      
        self.searchBar.tapInSearchBar()
        return true
    }
// конец ввода текста по resignFerstResponder
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.chars = []
        self.allGroupSeacrch = allGroups
        self.allGroupDictionary = sort(group: self.allGroupSeacrch)
        tableView.reloadData()
    }
 // Начало ввода текста
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.allGroupSeacrch = self.allGroups
        if searchText != "" {
        let newSearch = allGroupSeacrch.filter() {
            $0.nameGroup.contains(searchText)
        }
        self.allGroupSeacrch = newSearch
       
        }
        self.chars = []
        self.allGroupDictionary = sort(group: self.allGroupSeacrch)
        
        tableView.reloadData()
        
    }
     
    
    // MARK: - Table view data source

    // количество секций с одной буквой
        override func numberOfSections(in tableView: UITableView) -> Int {
            
           return self.chars.count
            //return self.allGroupDictionary.keys.count
        }
        
    // количество строк таблици в одной секции
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            let count = allGroupDictionary[self.chars[section]]?.count
//            let groupCell = allGroupDictionary.keys.sorted()
//            let cell = allGroupDictionary[groupCell[section]]?.count ?? 0
//
            return count ?? 0
        }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }
        if let firstchar = allGroupDictionary[self.chars[indexPath.section]] {
            let groupes = firstchar[indexPath.row]
            cell.profileStatus.text = ""
            cell.lableCellXib.text = groupes.nameGroup
            cell.imageCellAvatar.loadImageFromUrlString(groupes.imageGroup)//UIImage(data: groupes.imageGroup)
            cell.labelCityCellXib.text = "-"
        }else {
            return cell
        }
        return cell
        
    }
    
    // установка имени секции
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return self.chars[section]
        }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let arrayGroups = self.allGroupDictionary[self.shar[indexPath.section]]  else { return }
//        let selectedGroup = arrayGroups[indexPath.row]
//        self.joinNewGroup(to: selectedGroup.id) { status, message in
//
//            if message.first == "success" {
//                if arrayGroups.count <= 1 {
//                    let index = self.allGroupDictionary.firstIndex(where: {$0.key == self.shar[indexPath.section] })
//                    self.allGroupDictionary.remove(at: index!)
//                    self.shar.remove(at: indexPath.section)
//                    DispatchQueue.main.async {
//                        let indexSet = IndexSet(arrayLiteral: indexPath.section)
//                        self.tableView.deleteSections(indexSet, with: .fade)
//                    }
//                }else {
//                    let newArrayGroups = arrayGroups.filter{ $0.id != selectedGroup.id }
//                    self.allGroupDictionary[self.shar[indexPath.section]] = newArrayGroups
//                    DispatchQueue.main.async {
//                        self.tableView.deleteRows(at: [indexPath], with: .right)
//                    }
//                }
//
//
//            }else {
//                print(message)
//            }
//        }
//
//    }
    
   //  Установка бокового буквенного поиска
        override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            tableView.sectionIndexColor = UIColor(named: "AppBW")
            return self.chars
        }
    
    
    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        tableView.customzeSwipeView(for: self.tableView)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let detailsButton = UIContextualAction(style: .normal, title: "Подробно") { action, view, completion in
            
            
        }
        detailsButton.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        detailsButton.backgroundColor = #colorLiteral(red: 0.4643256664, green: 0.959634006, blue: 0.6755945086, alpha: 0.5767875204)
        let configuration = UISwipeActionsConfiguration(actions: [detailsButton])
        return configuration
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addingButton = UIContextualAction(style: .normal, title: "Добавить") { action, view, completion in
            
                    guard let arrayGroups = self.allGroupDictionary[self.chars[indexPath.section]]  else { return }
                    let selectedGroup = arrayGroups[indexPath.row]
                    self.joinNewGroup(to: selectedGroup.id) { status, message in
            
                        if message.first == "success" {
                            if arrayGroups.count <= 1 {
                                let index = self.allGroupDictionary.firstIndex(where: {$0.key == self.chars[indexPath.section] })
                                self.allGroupDictionary.remove(at: index!)
                                self.chars.remove(at: indexPath.section)
                                DispatchQueue.main.async {
                                    let indexSet = IndexSet(arrayLiteral: indexPath.section)
                                    self.tableView.deleteSections(indexSet, with: .fade)
                                }
                            }else {
                                let newArrayGroups = arrayGroups.filter{ $0.id != selectedGroup.id }
                                self.allGroupDictionary[self.chars[indexPath.section]] = newArrayGroups
                                DispatchQueue.main.async {
                                    self.tableView.deleteRows(at: [indexPath], with: .right)
                                }
                            }
            
            
                        }else {
                            print(message)
                        }
                    }
            
        }
        addingButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.5767875204)
        addingButton.image = UIImage(systemName: "plus.app")
        let configuration = UISwipeActionsConfiguration(actions: [addingButton])
        return configuration
    }
    

}


extension NewGroupTableViewController {
    
    private func sort(group: [AllNewUserGroups]) -> [String: [AllNewUserGroups]]{
        self.chars.removeAll()
        var groupDictionary = [String: [AllNewUserGroups]]()
        group.forEach() { grupes in
            guard let char = grupes.nameGroup.first(where: {
                $0 != " "
                || $0 != "."
                || $0 != ","
                || $0 != "!"
                || $0 != "="
                || $0 != "("
                || $0 != ")"
                || $0 != "!"
                || $0 != "{"
                || $0 != "}"
                || $0 != "%"
                || $0 != "/"
                || $0 != "?"
                
            }) else { return }
            let chars = String(char)
            if var thisCharGroup = groupDictionary[String(chars)] {
                thisCharGroup.append(grupes)
                groupDictionary[chars] = thisCharGroup
            }else {
                groupDictionary[chars] = [grupes]
                
                self.chars.append(String(chars))
            }
        }

        return groupDictionary
    }
    
    func setSearchFieldAllert() {
        // Алерт поиска групп
                self.searchBar.placeholder = "Поиск по найденым групам"
                let allert = UIAlertController(title: "Найти группу", message: "Введите текст для поиска...", preferredStyle: .alert)
                allert.addTextField()
                let action = UIAlertAction(title: "Искать", style: .default) { action in
                    if let searchtext = allert.textFields?.first?.text {
                        self.activityIndicator.isHidden = false
                        self.activityIndicator.startAnimating()
                        self.LoadNewGroupList(searchText: searchtext)
                    }
                }
                allert.addAction(action)
                self.allert = allert
    }
}


