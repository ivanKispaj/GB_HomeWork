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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 1
//    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return allGroup.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }
        cell.lableCellXib.text = allGroup[indexPath.row].nameGroup
        cell.imageCellAvatar.image = allGroup[indexPath.row].imageGroup
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newGroup = self.allGroup[indexPath.row]
        if (issetGroup(newGroup, groupArray: self.myActiveGroup)) == nil {
           
            self.myActiveGroup.append(newGroup)
            guard let index = issetGroup(newGroup, groupArray: self.allGroup) else { return }
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
  
}





