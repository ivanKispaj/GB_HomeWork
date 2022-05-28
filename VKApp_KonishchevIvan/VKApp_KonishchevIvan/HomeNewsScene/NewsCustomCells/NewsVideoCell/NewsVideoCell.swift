//
//  NewsVideoCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit
import AVKit
import AVFoundation;


class NewsVideoCell: UITableViewCell,DequeuableProtocol {

    @IBOutlet weak var videoUIView: UIView!
    var player: AVPlayer?
    var playerController: AVPlayerViewController?
    
    var videoData: NewsCellData?
    
    
    func configureCellForVideo(form data: NewsCellData) {
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/video.get").loadVideoContent(ovnerId: data.ownerId, accessKey: data.accessKey, videoId: data.videoId) { result in
                
                if let items = result {
                    self.player!.play()
                  
                }
                
            }
        }
        self.initializeVideoPlayerWithVideo()
    }
    
    func initializeVideoPlayerWithVideo() {
    
        if let videoURL = URL(string: "https://www.youtube.com/embed/0fAwQRfG1OE") {
            self.player = AVPlayer(url: videoURL)
            self.playerController = AVPlayerViewController()
            playerController?.player = player
            if let controller = self.playerController {
                self.videoUIView.addSubview(controller.view)
              
                
            }
         
        }
        
        
    }
    
}












