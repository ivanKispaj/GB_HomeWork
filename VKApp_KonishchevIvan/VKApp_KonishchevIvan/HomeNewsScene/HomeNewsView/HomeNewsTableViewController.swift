//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class HomeNewsTableViewController: UITableViewController{
    

    var nextViewData: [ImageAndLikeData?] = [nil]
    var newsArray:[NewsData]? = nil
    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        return 0 //self.newsArray!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoAndTextCell", for: indexPath) as? SinglePhotoAndTextTableViewCell else {
            preconditionFailure("Error")
        }
        let newsText = (self.newsArray![indexPath.row].newsText)!
        let newsImage = (self.newsArray![indexPath.row].newsImage)
        cell.newsTextView.text = newsText
        cell.controllerNewsImage = newsImage
        
// передаем контроллер и текущий индекс патч в делегат!!!
        cell.likeControll.delegate = self
        cell.likeControll.indexPath = indexPath
        
        cell.newsUserAvatar.image = UIImage(named: "abramovich")
        
        let countlike: String = String(newsArray![indexPath.row].newsImage!.likeLabel)
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


