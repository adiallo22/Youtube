//
//  WatchVideoVC.swift
//  Youtube
//
//  Created by Abdul Diallo on 6/9/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class WatchVideoVC: UIViewController {

    @IBOutlet weak var titleVideo: UILabel!
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    var id : String?
    var videoTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubePlayer.delegate = self
        titleVideo.text = videoTitle!
        playVideo()
        
    }
    
    @IBAction func exitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - <#section heading#>

extension WatchVideoVC : YTPlayerViewDelegate {
    
    func playVideo() {
        //guard let url = URL.init(string: "https://www.youtube.com/watch?v=\(id!)") else { return }
        guard let id = id else { return }
        youtubePlayer.load(withVideoId: id)
    }
    
}

//extension WatchVideoVC : VideoInfo {
//
//    func passVideoInfo(id: String?) {
//        guard let url = URL.init(string: "https://www.youtube.com/watch?v=\(id!)") else { return }
//        webPage.load(URLRequest(url: url))
//    }
//
//}
