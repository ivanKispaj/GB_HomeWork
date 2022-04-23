//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class HomeNewsTableViewController: UITableViewController{
    

    var nextViewData: [ImageAndLikeData?] = [nil]
    var newsArray:[NewsData]! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
    }
    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNewsData()
        
        self.currentOrientation = UIDevice.current.orientation
   //     self.newsArray = DataController.shared.getDataNews()
        tableView.register(UINib(nibName: "SinglePhotoAndTextTableViewCell", bundle: nil), forCellReuseIdentifier: "SinglePhotoAndTextCell")
    }


    // MARK: - Table view data source

    @objc func likeIsTapped() {
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
 
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.newsArray == nil {
            return 0
        }else {
        return self.newsArray!.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
            preconditionFailure("Error")
        }
    
        cell.newsData = newsArray[indexPath.row]
        
// передаем контроллер и текущий индекс патч в делегат!!!
        cell.likeControll.delegate = self
        cell.likeControll.indexPath = indexPath
        let url = self.newsArray[indexPath.row].newsUser.photo
        cell.newsUserAvatar.loadImageFromUrlString(url)
        cell.newsTextView.text = self.newsArray[indexPath.row].description
        let userName = self.newsArray[indexPath.row].newsUser.fName + " " + self.newsArray[indexPath.row].newsUser.lName
        cell.newsUserName.text = userName
        cell.newsLikeLable.text = String(self.newsArray[indexPath.row].newsLike.count)
        cell.newsUserApdateTime.text = unixTimeConvertion(unixTime: Double(self.newsArray[indexPath.row].newsSeen))
        let countlike: String = String(newsArray[indexPath.row].newsLike.count)
        cell.newsLikeLable.text = countlike
      
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Подготовить segue к переходу на другой контроллер просмотра фото
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // сделать переход на просмотр фото
        }
        
    
}


