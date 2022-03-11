//
//  NewGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

class NewGroupTableViewController: UITableViewController {

    var userGroupDelegate: UserGroupTableViewDelegate? = nil
    var allGroup: [AllUserGroups] = []
    var myActiveGroup: [AllUserGroups] = []
    var shar: [String] = []
    var allGroupDictionary = [String: [AllUserGroups]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allGroupDictionary = sort(group: allGroup)
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        
    }

 
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 1
//    }
//
    // количество секций с одной буквой
        override func numberOfSections(in tableView: UITableView) -> Int {
            return self.allGroupDictionary.keys.count
        }
        
    // количество строк таблици в одной секции
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let groupCell = allGroupDictionary.keys.sorted()
            let cell = allGroupDictionary[groupCell[section]]?.count ?? 0
            
            return cell//allGroupDictionary[groupCell[section]]?.count ?? 0
        }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }
        
        let firstchar = allGroupDictionary.keys.sorted()[indexPath.section]
        let group = allGroupDictionary[firstchar]!
        let groupes = group[indexPath.row]
        
        cell.lableCellXib.text = groupes.nameGroup
        cell.imageCellAvatar.image = groupes.imageGroup
        return cell
        
    }
    
    // установка имени секции
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return String(allGroupDictionary.keys.sorted()[section])
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let newGroup = self.allGroup[indexPath.row]
        let allDictionaryKey = self.allGroupDictionary.keys.sorted()[indexPath.section]
        let row = indexPath.row
        var groupArray = allGroupDictionary[allDictionaryKey]!
        let group = groupArray[row]
        
        groupArray.remove(at: row)
        allGroupDictionary[allDictionaryKey] = groupArray
        
       if (issetGroup(group, groupArray: self.myActiveGroup)) == nil {

            self.myActiveGroup.append(group)
            guard let index = issetGroup(group, groupArray: self.allGroup) else { return }
            self.allGroup.remove(at: index)
           
           tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                self.userGroupDelegate?.addNewGroup(self.myActiveGroup, allGroup: self.allGroup)
                self.navigationController?.popViewController(animated: true)
            }

        }else {
            let allert = AllertWrongUserData.getAllert(title: "Message", message: "You are already a member of this group!")
            present(allert, animated: true, completion: nil)
        }
    
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
//        for groupes in group {
//            guard let char = groupes.nameGroup.first else { return ["":[]]}
//            if var issetChar = groupDictionary[String(char)] {
//                issetChar.append(groupes)
//                groupDictionary[String(char)] = issetChar
//
//            }else {
//                self.shar.append(String(char))
//                groupDictionary[String(char)] = [groupes]
//            }
//        }
        return groupDictionary
    }
}




