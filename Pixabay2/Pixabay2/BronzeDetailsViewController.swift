//
//  BronzeDetailsViewController.swift
//  Pixabay2
//
//  Created by Bauyrzhan Muratbek on 4/26/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit
import AVKit

class BronzeDetailsViewController: UIViewController {

    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var isImage: Bool = true
    var imageURL: String = ""
    var mediumVideoURL: String = ""
    var tags: String = ""
    var player: AVPlayer?
    var url: String?
    
    @IBAction func onPlayPauseButtonPressed(_ sender: UIButton) {
        if (playPauseButton.tag == 1) {
            player?.play()
            playPauseButton.tag = 0
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            player?.pause()
            playPauseButton.tag = 1
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func share() {
        let linkToShare = [url]
        
        let activityVC = UIActivityViewController(activityItems: linkToShare ?? [], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityVC.excludedActivityTypes = [UIActivityType.airDrop]
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let shareBtn = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(BronzeDetailsViewController.share))
        self.navigationItem.rightBarButtonItem = shareBtn
        
        self.tagsLabel.text = tags
        
        if isImage {
            url = imageURL
            fullImageView.sd_setImage(with: URL(string: url!), completed: nil)
        } else {
            url = mediumVideoURL
            playPauseButton.isHidden = false
            player = AVPlayer(url: URL(string: url!)!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
        }
    }

}
