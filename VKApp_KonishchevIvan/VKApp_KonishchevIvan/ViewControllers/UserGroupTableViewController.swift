//
//  UserGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit
protocol UserGroupTableViewDelegate {
    func addNewGroup (_ group: [AllUserGroups], allGroup: [AllUserGroups] )
}

class UserGroupTableViewController: UITableViewController, UISearchBarDelegate{
  
    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var allGroup = DataController.shared.getdataGroup()
    var myActiveGroup = [
        AllUserGroups(nameGroup: "Рыбалка", logoGroup: UIImage.init(named: "Fishing"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    
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

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print("Header")
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

        cell.imageCellAvatar.image = myActiveGroup[indexPath.row].imageGroup
        cell.lableCellXib.text = myActiveGroup[indexPath.row].nameGroup
        return cell
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? NewGroupTableViewController else { return
        }
        destinationVC.userGroupDelegate = self
        destinationVC.allGroups = self.allGroup
        destinationVC.myActiveGroup = self.myActiveGroup
    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deliteRow = self.myActiveGroup[indexPath.row]
            let index = self.myActiveGroup.firstIndex(of: (deliteRow))
            self.myActiveGroup.remove(at: index!)
                if self.allGroup.firstIndex(of: deliteRow) == nil {
                    self.allGroup.append(deliteRow)
                }
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    }
    
    
   
}


