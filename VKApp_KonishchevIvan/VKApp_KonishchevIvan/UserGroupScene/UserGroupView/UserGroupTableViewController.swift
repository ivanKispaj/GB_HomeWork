//
//  UserGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class UserGroupTableViewController: UITableViewController, UISearchBarDelegate{
  
    let ref = Database.database().reference(withPath: "registerUser")
    
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
    var dataGroups: Results<ItemsGroup>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.setNitificationGroups()
        DispatchQueue.main.async {
            self.dataGroups = self.realmService.readData(ItemsGroup.self)

        }
        
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "XibCellForTable")
        tableView.register(UINib(nibName: "ExtendTableUserCell", bundle: nil), forCellReuseIdentifier: "ExtendCellXib")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadUserGroupFromVK()
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
    
        self.dataGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCellForTable", for: indexPath) as? TableViewCellXib else {
            preconditionFailure("Error")
        }
        guard let data = self.dataGroups else { return cell}
        
        cell.imageCellAvatar.image = UIImage(data: data[indexPath.row].photoGroup)
        cell.lableCellXib.text = data[indexPath.row].groupName
        cell.labelCityCellXib.text = data[indexPath.row].activity
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
        guard let data = self.dataGroups else { return }
        print(data[indexPath.row].id)
        
        if editingStyle == .delete {
            let id = data[indexPath.row].id
            self.leaveGroup(to: id) { status, message in
                if status {
                    DispatchQueue.main.async {
                        print(data[indexPath.row].id)
                        self.realmService.deliteData(data[indexPath.row])
                    }
                    DispatchQueue.main.async {
                        self.tableView.deleteRows(at: [indexPath], with: .right)
                    }
                }else {
                    print("Failure Delite groups")
                }
            }
            
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    }
    
    
   
}


