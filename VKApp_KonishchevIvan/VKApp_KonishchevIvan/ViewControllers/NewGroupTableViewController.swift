//
//  NewGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

class NewGroupTableViewController: UITableViewController {

    
    let allGroup = [
        AllUserGroups(nameGroup: "Баскетбол", logoGroup: UIImage.init(named: "Basketball")),
        AllUserGroups(nameGroup: "Стрельба из лука", logoGroup: UIImage.init(named: "BowShooting")),
        AllUserGroups(nameGroup: "Бальные танцы", logoGroup: UIImage.init(named: "Dances")),
        AllUserGroups(nameGroup: "Фехтование", logoGroup: UIImage.init(named: "Fencing")),
        AllUserGroups(nameGroup: "Рыбалка", logoGroup: UIImage.init(named: "Fishing")),
        AllUserGroups(nameGroup: "Футбол", logoGroup: UIImage.init(named: "Football")),
        AllUserGroups(nameGroup: "Художественная гимнастика", logoGroup: UIImage.init(named: "Gymnastic")),
        AllUserGroups(nameGroup: "Тяжелая атлетика", logoGroup: UIImage.init(named: "HardAttletic")),
        AllUserGroups(nameGroup: "Хоккей", logoGroup: UIImage.init(named: "Hockey")),
        AllUserGroups(nameGroup: "Прыжки в воду", logoGroup: UIImage.init(named: "JumpWather")),
        AllUserGroups(nameGroup: "Боевые искуства", logoGroup: UIImage.init(named: "Karate")),
        AllUserGroups(nameGroup: "Бег", logoGroup: UIImage.init(named: "Run")),
        AllUserGroups(nameGroup: "Теннис", logoGroup: UIImage.init(named: "Tennis")),
        AllUserGroups(nameGroup: "Велогонки", logoGroup: UIImage.init(named: "Velo")),
        AllUserGroups(nameGroup: "Волейбол", logoGroup: UIImage.init(named: "Volleyball"))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroup.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as? AllGroupsTableViewCell else {
            preconditionFailure("Error")
        }

        cell.allGroupLablel.text = allGroup[indexPath.row].nameGroup
        cell.allGroupView.image = allGroup[indexPath.row].imageGroup

        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
