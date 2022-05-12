//
//  UserGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit
import RealmSwift


class UserGroupTableViewController: UITableViewController, UISearchBarDelegate{
  
    @IBOutlet weak var searchBar: CustomCodeSearchBar!

    var nitifiTokenGroups: NotificationToken?
    let realmService = RealmService()
    var myActiveGroup: [AllUserGroups] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.setNitificationGroups()
        self.loadUserGroupFromVK()
           
      
        
        
        
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        tableView.register(UINib(nibName: "ExtendTableUserCell", bundle: nil), forCellReuseIdentifier: "ExtendCellXib")
        
    }

//MARK: - SearchBar Method
    // SearchBar FirstResponder
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.tapInSearchBar()
        return true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return myActiveGroup.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }

       
            cell.imageCellAvatar.loadImageFromUrlString(self.myActiveGroup[indexPath.row].imageGroup)

        cell.lableCellXib.text = myActiveGroup[indexPath.row].nameGroup
        cell.labelCityCellXib.text = myActiveGroup[indexPath.row].activity
        cell.profileStatus.text = ""
        return cell
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? NewGroupTableViewController else { return
        }
       destinationVC.userGroupDelegate = self
    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deliteRow = self.myActiveGroup[indexPath.row]
            let index = self.myActiveGroup.firstIndex(of: (deliteRow))
            self.myActiveGroup.remove(at: index!)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    }
    
    
   
}


