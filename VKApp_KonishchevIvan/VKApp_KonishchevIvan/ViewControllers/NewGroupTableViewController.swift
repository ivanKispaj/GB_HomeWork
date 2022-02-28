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
        AllUserGroups(nameGroup: "Художественная гимнастика", logoGroup: UIImage.init(named: "gymnastic")),
        AllUserGroups(nameGroup: "Тяжелая атлетика", logoGroup: UIImage.init(named: "HardAttletic")),
        AllUserGroups(nameGroup: "Хоккей", logoGroup: UIImage.init(named: "Hockey")),
        AllUserGroups(nameGroup: "Прыжки в воду", logoGroup: UIImage.init(named: "jumpWather")),
        AllUserGroups(nameGroup: "Боевые искуства", logoGroup: UIImage.init(named: "karate")),
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
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
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

}
