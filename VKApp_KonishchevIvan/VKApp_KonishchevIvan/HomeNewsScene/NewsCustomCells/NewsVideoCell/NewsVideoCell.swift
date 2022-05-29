//
//  NewsVideoCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit
import AVKit
import AVFoundation



class NewsVideoCell: UITableViewCell,DequeuableProtocol {

    @IBOutlet weak var videoUIView: UIView!

    var player: AVPlayer! {
        didSet {
            self.player.play()
        }
    }
    var playerViewController: AVPlayerViewController!
    
    var videoData: NewsCellData?
    
    
    func configureCellForVideo(form data: NewsCellData) {
        
//        let queue = DispatchQueue.global(qos: .userInteractive)
//        queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/video.get").loadVideoContent(ovnerId: data.ownerId, accessKey: data.accessKey, videoId: data.videoId) { result in
                
                if let playerUrl = result?.player {
                    
                    guard let url = URL(string: playerUrl) else {
                        print("Error: \(playerUrl) doesn't seem to be a valid URL")
                        return
                    }

                    do {
          
                        let playerHtml = try String(contentsOf: url, encoding: .ascii)
                       
                        let htmlArray = playerHtml.split(separator: ",")
                     //   let url480 = htmlArray.first(where: { $0.contains("url480")})
                       let url360 = htmlArray.first(where: { $0.contains("url360")})
                  //      let url240 = htmlArray.first(where: { $0.contains("url240")})
             
                        if let url480One = url360?.split(separator: ":") {
                            let url = url480One.last
                            if var clearUrl = url?.replacingOccurrences(of: "\\", with: "") {
                                clearUrl = clearUrl.replacingOccurrences(of: "\"", with: "")
                                clearUrl = "https:" + clearUrl
                                self.initializeVideoPlayerWithVideo(with: clearUrl)
                                
                            }
                        }
                    } catch let error {
                        print("Error: \(error)")
                    }
                  
                }
                
            }
     //   }
     
    }
      
    func initializeVideoPlayerWithVideo(with url: String) {
    
        let videoURL = URL(string: url)
        
      
           
        DispatchQueue.main.async {
            self.player = AVPlayer(url: videoURL!)
            self.playerViewController = AVPlayerViewController()
            self.playerViewController.player = self.player
            self.playerViewController.view.frame = self.videoUIView.frame
            self.playerViewController.player?.pause()
            self.playerViewController.showsPlaybackControls = false
            self.videoUIView.addSubview(self.playerViewController.view)
        }
          
    }
    
    func loopVideo(videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
}
    













