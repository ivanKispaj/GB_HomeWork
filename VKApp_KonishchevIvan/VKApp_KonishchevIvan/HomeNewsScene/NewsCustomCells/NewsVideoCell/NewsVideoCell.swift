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

    @IBOutlet weak var newsUserName: UILabel!
    @IBOutlet weak var newsUserAvatar: UIImageView!
    @IBOutlet weak var videoUIView: UIView!
    @IBOutlet weak var newsVideoFrameImage: UIImageView!
    @IBOutlet weak var newsUserSeen: UILabel!
    @IBOutlet weak var newsLikeCount: UILabel!
    @IBOutlet weak var newsSeenCount: UILabel!
    @IBOutlet weak var newsVideoText: UILabel!
    
    var player: AVPlayer! {
        didSet {
            self.player.play()
        }
    }
    var playerViewController: AVPlayerViewController!
    
    var videoData: NewsCellData?
    
    
    func configureCellForVideo(form data: NewsCellData) {
        self.newsVideoText.text = data.newsText
        self.newsUserName.text = data.newsUserName
        self.newsUserSeen.text = data.date.unixTimeConvertion()
        self.newsLikeCount.text = String(data.newsLikeCount)
        self.newsSeenCount.text = String(data.newsSeenCount)
        let ratio = (data.firstFrame.width) / UIScreen.main.bounds.width
        let height = (data.firstFrame.height) / ratio
        self.frame.size.height = height + 110
        let queue = DispatchQueue.global(qos: .userInteractive)
        
       queue.async {
            InternetConnections(host: "api.vk.com", path: "/method/video.get").loadVideoContent(ovnerId: data.ownerId, accessKey: data.accessKey, videoId: data.videoId) { result in
                
                if result?.player == nil {
                    DispatchQueue.main.async {
                        self.newsVideoFrameImage.loadImageFromUrlString(data.firstFrame.url)
                        self.videoUIView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: height)
                    }
                } else {
                if let playerUrl = result?.player {
                    
                    guard let url = URL(string: playerUrl) else {
                        print("Error: \(playerUrl) doesn't seem to be a valid URL")
                        return
                    }

                    do {
          
                        let playerHtml = try String(contentsOf: url, encoding: .ascii)
                       
                        let htmlArray = playerHtml.split(separator: ",")
                        if data.videoType == .video {
            // варианты url video 480/360/320
                            let url480 = htmlArray.first(where: { $0.contains("url480")})
                            let url360 = htmlArray.first(where: { $0.contains("url360")})
                            let url240 = htmlArray.first(where: { $0.contains("url240")})
                            var urlDataExt: [Substring.SubSequence]?
                            if let urlData = url480?.split(separator: ":") {
                                urlDataExt = urlData
                            }else if let urlData = url360?.split(separator: ":") {
                                urlDataExt = urlData
                            }else if let urlData = url240?.split(separator: ":") {
                                urlDataExt = urlData
                            }
                          
                            if let urlData = urlDataExt {
                                if let clearUrl = self.getClearUrl(from: urlData) {
                                    DispatchQueue.main.async {
                                        self.initializeVideoPlayerWithVideo(with: clearUrl)
                                    }
                                }
                              
                            }
                        }else if data.videoType == .live {
                            let allHls = htmlArray.filter({$0.contains ("hls")})
                            print(allHls.count)
                            print(allHls)
                            let urlHls = htmlArray.first(where: { $0.contains("hls")})
                            if let hls = urlHls?.split(separator: ":") {
                                let lastHls = hls.last
                                if var clearHls = lastHls?.replacingOccurrences(of: "\\", with: "") {
                                    clearHls = clearHls.replacingOccurrences(of: "\"", with: "")
                                    clearHls = "https:" + clearHls
                                    print(clearHls)
                                    DispatchQueue.main.async {
                                        self.initializeVideoPlayerWithVideo(with: clearHls)
                                    }
                                }
                            }
                        }
                    } catch let error {
                        print("Error: \(error)")
                    }
                  
                }
            }
            }
        }
        
    
    }
      
    func getClearUrl(from urlData: [Substring.SubSequence]) -> String? {
        let url = urlData.last
            if var clearUrl = url?.replacingOccurrences(of: "\\", with: "") {
                clearUrl = clearUrl.replacingOccurrences(of: "\"", with: "")
                clearUrl = "https:" + clearUrl
             return clearUrl
        }
      return nil
    }
    
    func initializeVideoPlayerWithVideo(with url: String) {
    
        let videoURL = URL(string: url)
        self.player = AVPlayer(url: videoURL!)
        self.player.isMuted = true
        self.playerViewController = AVPlayerViewController()
        self.playerViewController.player = self.player
        self.playerViewController.showsPlaybackControls = false
        self.videoUIView.addSubview(self.playerViewController.view)
        self.playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController.view.leadingAnchor.constraint(equalTo: self.videoUIView.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: self.videoUIView.trailingAnchor),
            playerViewController.view.topAnchor.constraint(equalTo: self.videoUIView.topAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: self.videoUIView.bottomAnchor)
        ])

          
    }
    
    func loopVideo(videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
}
    













