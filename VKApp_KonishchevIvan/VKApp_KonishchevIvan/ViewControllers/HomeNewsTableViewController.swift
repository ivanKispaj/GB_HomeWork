//
//  TableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
//
//"first_name" = "\U0410\U043b\U0438\U043d\U0430";
//id = 104566296;
//"is_closed" = 1;
//"last_name" = "\U0422\U043e\U043b\U044e\U043f\U0430";
//nickname = "";
//"track_code" = "29bc4477Oc9UsYFS7fbhGZG9-BOnYO5Mlx42m1OS3C-eaCuBx2NUpFmD6VbvobcXpjBTu1gMnViOEiH1Nw";
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//city =                 {
//    id = 1056420;
//    title = "\U0421\U043f\U0443\U0442\U043d\U0438\U043a";
//};
//"first_name" = "\U0412\U0430\U043a\U0438\U0444";
//"home_phone" = "";
//id = 160580578;
//"is_closed" = 0;
//"last_name" = "\U0424\U0430\U0439\U0437\U0440\U0430\U0445\U043c\U0430\U043d\U043e\U0432";
//"mobile_phone" = "8 9636454585.";
//nickname = "\U0430\U043b\U0435\U043a\U0441\U0430\U043d\U0434\U0440\U043e\U0432\U0438\U0447";
//"track_code" = "ea92e2abRcQLIIKf5DvC1ywMto-zKmd6R5HxaOJhId_MK7xtEgcorwEUucy2aMLaHoYTKUxGFG5eneYGhg";
//},
//        {
//"can_post" = 0;
//deactivated = banned;
//"first_name" = "\U0420\U0435\U0434\U0432\U0430\U043d";
//id = 186828928;
//"last_name" = "\U042d\U043c\U0438\U0440\U043e\U0432";
//"track_code" = bc6828edbWNcAEtXlhm44lka5yscl9DJsDGvFbhGQpqqaLfNfUMACAQxe1SWTeGxYpxHjeP7o92pPbh73A;
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//city =                 {
//    id = 799;
//    title = "\U0415\U0432\U043f\U0430\U0442\U043e\U0440\U0438\U044f";
//};
//"first_name" = "\U0423\U043b\U044b\U0431\U043a\U0430";
//"home_phone" = "+73656926244";
//id = 194896391;
//"is_closed" = 0;
//"last_name" = "\U041f\U0430\U043d\U0441\U0438\U043e\U043d\U0430\U0442";
//"mobile_phone" = "+79787127159";
//nickname = "";
//"track_code" = "b13e502cb06nMAmsW_3RP6mzKVJPHpHXd5rACtIQSp35J6gkNegCJfQEN_8B8No_mz-C_bBy4sNultdktg";
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//"first_name" = "\U041a\U0430\U0442\U0435\U0440\U0438\U043d\U0430";
//"home_phone" = "";
//id = 281353802;
//"is_closed" = 0;
//"last_name" = "\U0421\U0442\U0435\U043f\U0430\U043d\U0435\U043d\U043a\U043e";
//"mobile_phone" = "";
//nickname = "";
//"track_code" = "e3e4d85eD4vC0vebNDXm16vTbR-_KHXfRKJ7-1zqIxy6XiOcfUli4M3rxshvMeCEnVTPs0BEBstdrmyVOA";
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//"first_name" = "\U0418\U0432\U0430\U043d";
//"home_phone" = "";
//id = 387485849;
//"is_closed" = 0;
//"last_name" = "\U041a\U043e\U043d\U0438\U0449\U0435\U0432";
//"mobile_phone" = "";
//nickname = "";
//"track_code" = "c0d264f8pgCm1JjSeR8DMhPrWvT3vE9nBbpnpfIIq7lNqknFAujLa_vlodMlGw44IGz8UwjQPHMctnDLlg";
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//city =                 {
//    id = 1;
//    title = "\U041c\U043e\U0441\U043a\U0432\U0430";
//};
//"first_name" = "\U042d\U043b\U043b\U0430\U0434\U0430";
//"home_phone" = "";
//id = 686974686;
//"is_closed" = 0;
//"last_name" = "\U041c\U0430\U0440\U0442\U0438\U0440\U043e\U0441\U044f\U043d";
//"mobile_phone" = "";
//nickname = "";
//"track_code" = "16bb52542-cQGOeO24c4ogSniia3f2l0ory2RnHKB2mDpU9PLj22jBkq2onRgmPwNy4gjkgTGmC7sKEoFQ";
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//"first_name" = Detailing;
//"home_phone" = "";
//id = 689120171;
//"is_closed" = 0;
//"last_name" = Famo;
//"mobile_phone" = "";
//nickname = "";
//"track_code" = "3a02cd96wFulJtRNCcT7ClTJromc1BgJVFYfgS5dlGCkLXebat-tMP9H7RkAyf9bbEcLJmO4ax1NWgjvSg";
//},
//        {
//"can_access_closed" = 1;
//"can_post" = 1;
//"first_name" = "\U041b\U044e\U0431\U043e\U0432\U044c";
//"home_phone" = "";
//id = 693988207;
//"is_closed" = 0;
//"last_name" = "\U0410\U043d\U0434\U0440\U0435\U0435\U0432\U0430";
//"mobile_phone" = "";
//nickname = "";
//"tr
//
            

class HomeNewsTableViewController: UITableViewController{
    

    var nextViewData: [ImageAndLikeData?] = [nil]
    var newsArray:[NewsData]? = nil
    var currentOrientation: UIDeviceOrientation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//MARK: - Internet request VK api

        // получение друзей по id пользователя
        InternetConnections.share.getListOfFirends(for: "72287677")
        // получение фото пользователя по id пользователя
        InternetConnections.share.getPhotoUser(for: "72287677")
        //получение групп пользователя по id пользователя
        InternetConnections.share.getUserGroups(for: "281353802")
        //Получение групп по запросу и типу группы
        InternetConnections.share.getGroupsByRequest(textRequset: "auto", typeCommunity: .group)
      //  controll.addTarget(self, action: #selector (likeIsTapped), for: .valueChanged)
        
        self.currentOrientation = UIDevice.current.orientation
        self.newsArray = DataController.shared.getDataNews()
        tableView.register(UINib(nibName: "SinglePhotoAndTextTableViewCell", bundle: nil), forCellReuseIdentifier: "SinglePhotoAndTextCell")
    }


    // MARK: - Table view data source

    @objc func likeIsTapped() {
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsArray!.count
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
        guard let destinationVC = segue.destination as? PhotoGallaryPressetViewController else { return
        }
        destinationVC.dataCollection = self.nextViewData
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            let photo: [ImageAndLikeData?] = [self.newsArray![indexPath.row].newsImage]
            self.nextViewData = photo
            self.performSegue(withIdentifier: "NewsPhotoPreviewID", sender: nil)
        
        }
    }
}

// MARK: - методы для делегата like controll !!
extension HomeNewsTableViewController: ProtocolLikeDelegate {

    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let countLike = newsArray![indexPath.row].newsImage?.likeLabel
        let likeStatus = newsArray![indexPath.row].newsImage?.likeStatus
        return [countLike!: likeStatus!]
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.newsArray![indexPath.row].newsImage?.likeStatus = likeStatus
        self.newsArray![indexPath.row].newsImage?.likeLabel = countLike
    }
}
