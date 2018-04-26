//
//  Gold.swift
//  Timer App
//
//  Created by Muratbek Bauyrzhan on 2/11/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Gold: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startPauseButton: UIButton!
    @IBOutlet var restartButton: UIButton!
    var timer = Timer()
    var seconds: Int = 60
    
    @IBAction func onStartPauseButtonPressed(_ sender: Any) {
        if(startPauseButton.currentTitle! == "Start") {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Gold.decreaseSeconds), userInfo: nil, repeats: true)
            startPauseButton.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func onRestartButtonPressed(_ sender: Any) {
        seconds = 60
        timerLabel.text = "01:00"
    }
    
    @objc func decreaseSeconds() {
        seconds -= 1
        if seconds == 0 {
            timer.invalidate()
            startPauseButton.isHidden = true
            restartButton.isHidden = true
        }
        timerLabel.text = String(format: "%02d", seconds / 60) + ":" + String(format : "%02d", seconds % 60)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

