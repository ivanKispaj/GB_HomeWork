//
//  NewGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

class NewGroupTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBAction func NewSearchGroup(_ sender: Any) {
        setSearchFieldAllert()
        self.present(self.allert, animated: true)
        self.allert = nil
    }
    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    // аллерт для поиска групп
    var allert: UIAlertController!
    var userGroupDelegate: UserGroupTableViewDelegate? = nil
    var allGroups: [AllUserGroups] = []{
        didSet {
            self.allGroupSeacrch = allGroups
            self.allGroupDictionary = sort(group: allGroupSeacrch)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var allGroupSeacrch: [AllUserGroups] = []
    var myActiveGroup: [AllUserGroups] = []
    var shar: [String] = []
    var allGroupDictionary = [String: [AllUserGroups]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchFieldAllert()
        self.searchBar.delegate = self
        self.allGroupSeacrch = self.allGroups
        self.allGroupDictionary = sort(group: allGroupSeacrch)
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        
    }
// MARK: - SearchBar
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.present(self.allert, animated: true)
        self.allert = nil
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
      
        self.searchBar.tapInSearchBar()
        return true
    }
// конец ввода текста по resignFerstResponder
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.shar = []
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
        self.shar = []
        self.allGroupDictionary = sort(group: self.allGroupSeacrch)
        
        tableView.reloadData()
        
    }
     
    
    // MARK: - Table view data source

    // количество секций с одной буквой
        override func numberOfSections(in tableView: UITableView) -> Int {
            return self.allGroupDictionary.keys.count
        }
        
    // количество строк таблици в одной секции
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let groupCell = allGroupDictionary.keys.sorted()
            let cell = allGroupDictionary[groupCell[section]]?.count ?? 0
            
            return cell
        }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }
        
        let firstchar = allGroupDictionary.keys.sorted()[indexPath.section]
        let group = allGroupDictionary[firstchar]!
        let groupes = group[indexPath.row]
        cell.profileStatus.text = ""
        cell.lableCellXib.text = groupes.nameGroup
        cell.imageCellAvatar.loadImageFromUrlString(groupes.imageGroup)
        cell.labelCityCellXib.text = "-"
    
        return cell
        
    }
    
    // установка имени секции
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return String(allGroupDictionary.keys.sorted()[section])
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//MARK: - Реализация этого метода добавления групп через VK  будет позже ....
//        let allDictionaryKey = self.allGroupDictionary.keys.sorted()[indexPath.section]
//        let row = indexPath.row
//        var groupArray = allGroupDictionary[allDictionaryKey]!
//        let group = groupArray[row]
//
//        groupArray.remove(at: row)
//        allGroupDictionary[allDictionaryKey] = groupArray
//
//       if (issetGroup(group, groupArray: self.myActiveGroup)) == nil {
//
//            self.myActiveGroup.append(group)
//            guard let index = issetGroup(group, groupArray: self.allGroupSeacrch) else { return }
//            self.allGroupSeacrch.remove(at: index)
//
//           tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
//                self.userGroupDelegate?.addNewGroup(self.myActiveGroup, allGroup: self.allGroupSeacrch)
//                self.navigationController?.popViewController(animated: true)
//            }
//
//        }else {
//            let allert = AllertWrongUserData().getAllert(title: "Message", message: "You are already a member of this group!")
//            present(allert, animated: true, completion: nil)
//        }
    
    }
    
   //  Установка бокового буквенного поиска
        override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            tableView.sectionIndexColor = UIColor(named: "AppBW")
            return self.shar
        }
}

extension NewGroupTableViewController {
    
    private func sort(group: [AllUserGroups]) -> [String: [AllUserGroups]]{
        
        var groupDictionary = [String: [AllUserGroups]]()
        group.forEach() { grupes in
            guard let char = grupes.nameGroup.first else { return }
            let chars = String(char)
            if var thisCharGroup = groupDictionary[String(chars)] {
                thisCharGroup.append(grupes)
                groupDictionary[chars] = thisCharGroup
            }else {
                groupDictionary[chars] = [grupes]
                self.shar.append(String(chars))
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
                        self.LoadNewGroupList(searchText: searchtext)
                    }
                }
                allert.addAction(action)
                self.allert = allert
    }
}




