//
//  FriendsTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {


    let friends = [
        Friends(image: UIImage.init(named: "Putin"), name: "Путин", userDetails: "Путин Владимир Владимирович. Президент Российской Федерации. Дата рождения: 7 октября 1952 г. Родился в Ленинграде 1975 г. — закончил юридический факультет Ленинградского государственного университета"),
        Friends(image: UIImage.init(named: "Bregnev"), name: "Брежнев", userDetails: "Брежнев Леонид Ильич (1906—1982), советский политический деятель, Генеральный секретарь ЦК КПСС (с 1966 г.), Председатель Президиума Верховного Совета СССР (с 1977 г.). Родился 19 декабря 1906 г. в селе Каменском (ныне город Днепродзержинск, Украина) в семье рабочего-металлурга"),
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

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsTableViewCell else {
            preconditionFailure("FriendsCell cannot")
        }
        cell.tableCellImage.makeCircle()
        cell.tableCellImage.image = friends[indexPath.row].avatar
        cell.tableCellLable.text = friends[indexPath.row].name
        
 

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDetailsFirends",
           let destinationVC = segue.destination as? DetailsCollectionViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            let friend = friends[indexPath.row].name
            let avatar = friends[indexPath.row].avatar
            let userDetail = friends[indexPath.row].userDetails
            destinationVC.title = friend
            destinationVC.name = friend
            destinationVC.avatar = avatar
            destinationVC.detailText = userDetail
            
        }
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
