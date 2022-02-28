//
//  UserGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

class UserGroupTableViewController: UITableViewController {

    var myActiveGroup = [
        AllUserGroups(nameGroup: "Рыбалка", logoGroup: UIImage.init(named: "Fishing"))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return myActiveGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? MyGroupsTableViewCell else {
            preconditionFailure("Error")
        }


        cell.myGroupLogo.image = myActiveGroup[indexPath.row].imageGroup
        cell.myGrouplable.text = myActiveGroup[indexPath.row].nameGroup
        return cell
    }
    
    @IBAction func addSelectedgroup(segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? NewGroupTableViewController,
        let indexPath = sourceVC.tableView.indexPathForSelectedRow else {
            preconditionFailure("Error")
        }
        if let index = self.myActiveGroup.firstIndex(of: (sourceVC.allGroup[indexPath.row])){
            myActiveGroup.remove(at: index)
            let allert = AllertWrongUserData.getAllert(title: "Caoution!", message: "Вы уже состоите в этой группе!")
            present(allert, animated: true, completion: nil)
        }
        myActiveGroup.append(sourceVC.allGroup[indexPath.row])
        tableView.reloadData()
 
        
    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = self.myActiveGroup.firstIndex(of: (self.myActiveGroup[indexPath.row]))
            self.myActiveGroup.remove(at: index!)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
