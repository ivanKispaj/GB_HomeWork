//
//  FriendsTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    struct DataSection {
        var header: String = ""
        var row: [Friends] = []
        init(header: String, row: [Friends]){
            self.header = header
            self.row = row
        }
    }
    
    private var friends: [DataSection] = [] // будущий массив по буквам
    
    // Исходный массив друзей
    private var friendsAlphavite = [
        Friends(image: UIImage.init(named: "Putin"), name: "Путин"),
        Friends(image: UIImage.init(named: "Bregnev"), name: "Брежнев"),
        Friends(image: UIImage.init(named: "FranclinRuzvelt"), name: "Франклин Рузвельт"),
        Friends(image: UIImage.init(named: "MaoCzydun"), name: "Мао Дзядун"),
        Friends(image: UIImage.init(named: "MargaretTetcher"), name: "Маргарет Тетчер"),
        Friends(image: UIImage.init(named: "Merkel"), name: "Меркель"),
        Friends(image: UIImage.init(named: "MohandasGandi"), name: "Мохандос Ганди"),
        Friends(image: UIImage.init(named: "Stalin"), name: "Сталин"),
        Friends(image: UIImage.init(named: "WinstonCherchil"), name: "Винстон Черчиль"),
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Можно снять коментарий чтобы отсортировать друзей по алфавиту!
       // self.friendsAlphavite = friendsAlphavite.sorted(by: { $0.name < $1.name })
      
        for nextArr in friendsAlphavite {
            let char = nextArr.name.first!
            let index = friends.firstIndex(where: {$0.header == String(char) })
   
            if index == nil {
                friends.append(DataSection(header: String(char), row: [nextArr]))
            }else {
                friends[index!].row.append(nextArr)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       // количество секций с одной буквой
        return friends.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // количество строк таблици в одной секции
        return friends[section].row.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
        return friends[section].header
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsTableViewCell else {
            preconditionFailure("FriendsCell cannot")
        }
       
        cell.tableCellImage.image = friends[indexPath.section].row[indexPath.row].avatar
        cell.tableCellLable.text = friends[indexPath.section].row[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDetailsFirends",
           let destinationVC = segue.destination as? DetailsCollectionViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            let friend = friends[indexPath.section].row[indexPath.row].name
            let avatar = friends[indexPath.section].row[indexPath.row].avatar
            destinationVC.title = friend
            destinationVC.name = friend
            destinationVC.avatar = avatar
    
            
        }
    }



}
