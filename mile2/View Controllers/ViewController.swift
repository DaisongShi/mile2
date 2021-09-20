//
//  ViewController.swift
//  mile2
//
//  Created by Boqian Wen on 2021-04-04.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    func setUpElements(){
        
        Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHollewButton(loginBtn)
        
        
    }
    func setUpVideo(){
        
       let bundlePath = Bundle.main.path(forResource: "Puppy - 1047", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        
        // adjust the size od video
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 0.5)
    }

}

