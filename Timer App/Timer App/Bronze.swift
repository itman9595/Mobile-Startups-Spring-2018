//
//  ViewController.swift
//  Timer App
//
//  Created by Muratbek Bauyrzhan on 2/11/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Bronze: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startPauseButton: UIButton!
    var timer = Timer()
    var seconds: Int = 0
    
    @IBAction func onStartPauseButtonPressed(_ sender: Any) {
        if(startPauseButton.currentTitle! == "Start") {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Bronze.increaseSeconds), userInfo: nil, repeats: true)
            startPauseButton.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func onRestartButtonPressed(_ sender: Any) {
        seconds = 0
        timerLabel.text = "00:00"
    }
    
    @objc func increaseSeconds() {
        seconds += 5
        timerLabel.text = String(format: "%02d", seconds / 60) + ":" + String(format : "%02d", seconds % 60)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
