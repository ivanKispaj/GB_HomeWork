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
    var allGroups: [AllNewUserGroups] = []{
        didSet {
            self.allGroupSeacrch = allGroups
            self.allGroupDictionary = sort(group: allGroupSeacrch)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var allGroupSeacrch: [AllNewUserGroups] = []
    var myActiveGroup: [AllNewUserGroups] = []
    var shar: [String] = []
    var allGroupDictionary = [String: [AllNewUserGroups]]()
    
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
            
           return self.shar.count
            //return self.allGroupDictionary.keys.count
        }
        
    // количество строк таблици в одной секции
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            let count = allGroupDictionary[self.shar[section]]?.count
//            let groupCell = allGroupDictionary.keys.sorted()
//            let cell = allGroupDictionary[groupCell[section]]?.count ?? 0
//
            return count ?? 0
        }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }
        if let firstchar = allGroupDictionary[self.shar[indexPath.section]] {
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
            return self.shar[section]
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let arrayGroups = self.allGroupDictionary[self.shar[indexPath.section]]  else { return }
        let selectedGroup = arrayGroups[indexPath.row]
        self.joinNewGroup(to: selectedGroup.id) { status, message in
            
            if message.first == "success" {
                if arrayGroups.count <= 1 {
                    let index = self.allGroupDictionary.firstIndex(where: {$0.key == self.shar[indexPath.section] })
                    self.allGroupDictionary.remove(at: index!)
                    self.shar.remove(at: indexPath.section)
                    DispatchQueue.main.async {
                        let indexSet = IndexSet(arrayLiteral: indexPath.section)
                        self.tableView.deleteSections(indexSet, with: .fade)
                    }
                }else {
                    let newArrayGroups = arrayGroups.filter{ $0.id != selectedGroup.id }
                    self.allGroupDictionary[self.shar[indexPath.section]] = newArrayGroups
                    DispatchQueue.main.async {
                        self.tableView.deleteRows(at: [indexPath], with: .right)
                    }
                }
                
                
            }else {
                print(message)
            }
        }
    
    }
    
   //  Установка бокового буквенного поиска
        override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            tableView.sectionIndexColor = UIColor(named: "AppBW")
            return self.shar
        }
}

extension NewGroupTableViewController {
    
    private func sort(group: [AllNewUserGroups]) -> [String: [AllNewUserGroups]]{
        
        var groupDictionary = [String: [AllNewUserGroups]]()
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




