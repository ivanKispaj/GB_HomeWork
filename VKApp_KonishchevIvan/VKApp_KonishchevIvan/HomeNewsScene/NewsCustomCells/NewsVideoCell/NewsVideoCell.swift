//
//  NewsVideoCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit
import AVKit
import AVFoundation



class NewsVideoCell: UITableViewCell, DequeuableProtocol {

    @IBOutlet weak var newsUserName: UILabel!
    @IBOutlet weak var newsUserAvatar: UIImageView!
    @IBOutlet weak var videoUIView: UIView!
    @IBOutlet weak var newsVideoFrameImage: UIImageView!
    @IBOutlet weak var newsUserSeen: UILabel!
    @IBOutlet weak var newsLikeCount: UILabel!
    @IBOutlet weak var newsSeenCount: UILabel!
    @IBOutlet weak var newsVideoText: UILabel!
    @IBOutlet weak var newsVideoHeightConstraint: NSLayoutConstraint!
    
    var playerViewController: AVPlayerViewController!
    
    var videoData: NewsCellData?
    var videoUrl: String? = nil {
        didSet {
            DispatchQueue.main.async {
                let videoURL = URL(string: self.videoUrl!)
                let player = AVPlayer(url: videoURL!)
                player.isMuted = true
                player.play()
                
                self.playerViewController.player = player
            }

        }
    }
    
    func configureCellForVideo(form data: NewsCellData) {
        self.newsVideoText.font = UIFont.systemFont(ofSize: 12)
        self.newsVideoText.text = data.newsText
        self.newsUserName.text = data.newsUserName
        self.newsUserSeen.text = data.date.unixTimeConvertion()
        self.newsLikeCount.text = String(data.newsLikeCount)
        self.newsSeenCount.text = String(data.newsSeenCount)
        let videoHeight = data.firstFrame.height * 0.7
        self.newsVideoHeightConstraint.constant = videoHeight
        self.setVideoPlayerController()
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            self.getVideoUrl(from: data)
            
        }

    }
      

    
    func initializeVideoPlayerWithVideo(with url: String) {
        self.playerViewController = AVPlayerViewController()
        self.playerViewController.videoGravity = .resizeAspectFill
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
    
    
    private func setVideoPlayerController() {
        self.playerViewController = AVPlayerViewController()
        self.playerViewController.videoGravity = .resizeAspectFill
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
    
    private func getVideoUrl(from data: NewsCellData) {
        InternetConnections(host: "api.vk.com", path: "/method/video.get").loadVideoContent(ovnerId: data.ownerId, accessKey: data.accessKey, videoId: data.videoId) { [weak self] result in
            if result?.player == nil {
                DispatchQueue.main.async {
                    let videoHeight = data.firstFrame.height * 0.7
                    self?.newsVideoFrameImage.loadImageFromUrlString(data.firstFrame.url)
                    self?.videoUIView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: videoHeight)
                }
            } else {
                guard let url = URL(string: result!.player) else {
                    print("Error: \(result!.player) doesn't seem to be a valid URL")
                    return
                }
                
                do {
                    let html = try String(contentsOf: url, encoding: .ascii)
                    let htmlArray = html.split(separator: ",")
                    
                    switch data.videoType {
                    case .video:
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
                            if let clearUrl = self?.getClearUrl(from: urlData) {
                                self?.videoUrl = clearUrl
                            }
                            
                        }
                    case .live:
                        let urlHls = htmlArray.first(where: { $0.contains("hls")})
                        if let hls = urlHls?.split(separator: ":") {
                            let lastHls = hls.last
                            if var clearHls = lastHls?.replacingOccurrences(of: "\\", with: "") {
                                clearHls = clearHls.replacingOccurrences(of: "\"", with: "")
                                clearHls = "https:" + clearHls
                                self?.videoUrl = clearHls
                            }
                        }
                    }
                }catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    private func getClearUrl(from urlData: [Substring.SubSequence]) -> String? {
        let url = urlData.last
            if var clearUrl = url?.replacingOccurrences(of: "\\", with: "") {
                clearUrl = clearUrl.replacingOccurrences(of: "\"", with: "")
                clearUrl = "https:" + clearUrl
             return clearUrl
        }
      return nil
    }
    
}
    













