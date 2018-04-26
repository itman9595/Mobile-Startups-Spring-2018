//
//  GoldDetailsViewController.swift
//  Pixabay2
//
//  Created by Bauyrzhan Muratbek on 4/26/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit
import AVKit

class GoldDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var zoomArea: UIScrollView!
    
    var isImage: Bool = true
    var imageURL: String = ""
    var mediumVideoURL: String = ""
    var tags: String = ""
    var player: AVPlayer?
    var url: String?
    var hideAddFavBtn: Bool = false
    
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
    
    func addToFavourites() {
        let defaults = UserDefaults.standard
        defaults.setValue(imageURL, forKey: "imageURL")
        defaults.setValue(mediumVideoURL, forKey: "mediumVideoURL")
        defaults.setValue(tags, forKey: "tags")
        
        let alert = UIAlertController(title: "Alert", message: "Added to Favourites", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if (!isImage) {
            return self.view
        }
        return fullImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomArea.minimumZoomScale = 1.0
        zoomArea.maximumZoomScale = 6.0
        zoomArea.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let shareBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        shareBtn.setBackgroundImage(UIImage(named: "share"), for: .normal)
        shareBtn.addTarget(self, action: #selector(GoldDetailsViewController.share), for: .touchUpInside)
        
        let shareBarBtn = UIBarButtonItem(customView: shareBtn)
        let shareBarBtnWidth = shareBarBtn.customView?.widthAnchor.constraint(equalToConstant: 24)
        shareBarBtnWidth?.isActive = true
        let shareBarBtnHeight = shareBarBtn.customView?.heightAnchor.constraint(equalToConstant: 24)
        shareBarBtnHeight?.isActive = true
        
        if (hideAddFavBtn) {
            self.navigationItem.rightBarButtonItem = shareBarBtn
        } else {
        
            shareBarBtn.imageInsets = UIEdgeInsetsMake(0, 0, 0, -25.0)
            
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            space.width = -16.0
            
            let favouriteBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(GoldDetailsViewController.addToFavourites))
            favouriteBarBtn.imageInsets = UIEdgeInsetsMake(0, -25, 0, 0)
            
            self.navigationItem.rightBarButtonItems = [space, favouriteBarBtn, shareBarBtn]
        }
        
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


