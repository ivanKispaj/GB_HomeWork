//
//  LoadNewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

extension HomeNewsTableViewController {
    func loadNewsData() {
      //  self.activityIndicator.isHidden = false
      //  self.activityIndicator.startAnimating()
//MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
      InternetConnections(host: "api.vk.com", path: "/method/newsfeed.get").getUserNews() { [weak self] response in
          switch response {
// обработка ответа
          case .success(let result):
              var newsData: [NewsData] = []
              var index = 0
              var imageString: String = ""
              for newsArray in result.response.items {
                  if newsArray.attachments[0].type == "photo" {
                      for image in newsArray.attachments[0].photoData!.photoArray {
                          if image.type == "y"{
                              imageString = image.url
                              break
                          }
                      }
                      if index >= result.response.profiles.count{
                          index -= 1
                      }
                      let news = NewsData(cellType: .photo, newsText: newsArray.attachments[0].photoData?.text, newsImage: imageString, newsLike: newsArray.likes, newsUser: result.response.profiles[index], newsSeen: newsArray.views.count, title: (newsArray.attachments[0].photoData?.text)!, description: "Обновил фото")
                      newsData.append(news)
                      index += 1
                      
                  }else if newsArray.attachments[0].type == "link" {
                      for image in newsArray.attachments[0].link!.photo.photoArray{
                          if image.type == "k"{
                              imageString = image.url
                              break
                          }
                      }
                      if index >= result.response.profiles.count {
                          index -= 1
                      }
                      let news = NewsData(cellType: .link, newsText: newsArray.attachments[0].link?.title, newsImage: imageString, newsLike: newsArray.likes, newsUser: result.response.profiles[index], newsSeen: newsArray.views.count, title: (newsArray.attachments[0].link?.caption)!, description: newsArray.attachments[0].link?.description)
                      newsData.append(news)
                      index += 1
                  }

                  }

              self?.newsArray = newsData
    
          case .failure(_):
              print("ErrorLoadDataVK")
          }
      }
    }
}
