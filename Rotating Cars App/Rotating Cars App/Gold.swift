//
//  Gold.swift
//  Rotating Cars App
//
//  Created by Muratbek Bauyrzhan on 2/10/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Gold: UIViewController {
    
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var middleImageView: UIImageView!
    @IBOutlet var bottomImageView: UIImageView!
    @IBOutlet var timerLabel: UILabel!
    
    var timer = Timer()
    var seconds: Int = 0
    
    @objc func increaseSeconds() {
        seconds += 1
        timerLabel.text = String(format: "%02d", seconds / 60) + ":" + String(format : "%02d", seconds % 60)
        
        if seconds % 10 == 0 {
            let topImage = topImageView.image
            topImageView.image = middleImageView.image
            middleImageView.image = bottomImageView.image
            bottomImageView.image = topImage
            timerLabel.textColor = UIColor.red
            timerLabel.font.withSize(100)
        } else {
            timerLabel.textColor = UIColor.black
            timerLabel.font.withSize(70)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Gold.increaseSeconds), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


