//
//  Silver.swift
//  SpyDetector
//
//  Created by Muratbek Bauyrzhan on 4/8/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Silver: UIViewController {
    @IBOutlet var leftColorLabel: UILabel!
    @IBOutlet var rightColorLabel: UILabel!
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var noBtn: UIButton!
    @IBOutlet var yesBtn: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startPauseButton: UIButton!
    var timer = Timer()
    var seconds: Int = 0
    var correctAnswers = 0
    var wrongAnswers = 0
    var results: UIAlertController!
    
    @IBAction func onStartPauseButtonPressed(_ sender: Any) {
        if(startPauseButton.currentTitle! == "Start") {
            noBtn.isEnabled = true
            yesBtn.isEnabled = true
            leftColorLabel.isHidden = false
            rightColorLabel.isHidden = false
            noBtn.setTitleColor(UIColor.white, for: .normal)
            yesBtn.setTitleColor(UIColor.white, for: .normal)
            timerLabel.text = "00:00"
            correctAnswers = 0
            wrongAnswers = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Silver.increaseSeconds), userInfo: nil, repeats: true)
            startPauseButton.setTitle("Pause", for: .normal)
        } else {
            noBtn.isEnabled = false
            yesBtn.isEnabled = false
            leftColorLabel.isHidden = true
            rightColorLabel.isHidden = true
            noBtn.setTitleColor(UIColor.gray, for: .normal)
            yesBtn.setTitleColor(UIColor.gray, for: .normal)
            timer.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
            seconds = 0
            results.message = "Correct: \(correctAnswers)\nWrong: \(wrongAnswers)"
            statusImageView.isHidden = true
            self.present(results, animated: true, completion: nil)
        }
    }
    
    @objc func increaseSeconds() {
        seconds += 1
        timerLabel.text = String(format: "%02d", seconds / 60) + ":" + String(format : "%02d", seconds % 60)
    }
    
    @IBAction func onNoButtonPressed(_ sender: UIButton) {
        if(leftTitleIndex != rightColorIndex) {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "success")
            correctAnswers += 1
        } else {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "fail")
            wrongAnswers += 1
        }
        
        setupViews()
    }
    
    @IBAction func onYesButtonPressed(_ sender: UIButton) {
        if(leftTitleIndex == rightColorIndex) {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "success")
            correctAnswers += 1
        } else {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "fail")
            wrongAnswers += 1
        }
        
        setupViews()
    }
    
    var leftColorIndex = 0
    var leftTitleIndex = 0
    
    var rightColorIndex = 0
    var rightTitleIndex = 0
    
    var colors = [UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.red, UIColor.yellow, UIColor.cyan, UIColor.brown]
    var titles = ["Black", "Green", "Purple", "Orange", "Red", "Yellow", "Cyan", "Brown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        leftView.layer.cornerRadius = 8
        rightView.layer.cornerRadius = 8
        
        leftView.layer.shadowOpacity = 0.5
        leftView.layer.shadowOffset = CGSize(width: 0, height: 2)
        leftView.layer.shadowRadius = 10
        leftView.layer.shadowColor = UIColor.black.cgColor
        
        rightView.layer.shadowOpacity = 0.5
        rightView.layer.shadowOffset = CGSize(width: 0, height: 2)
        rightView.layer.shadowRadius = 10
        rightView.layer.shadowColor = UIColor.black.cgColor
        
        results = UIAlertController(title: "Results", message: "Correct: \(correctAnswers)\nWrong: \(wrongAnswers)", preferredStyle: UIAlertControllerStyle.alert)
        results.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        setupViews()
    }
    
    func setupViews() {
        leftColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        leftTitleIndex = Int(arc4random_uniform(UInt32(titles.count)))
        
        rightColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        rightTitleIndex = Int(arc4random_uniform(UInt32(titles.count)))
        
        leftColorLabel.textColor = colors[leftColorIndex]
        leftColorLabel.text = titles[leftTitleIndex]
        
        rightColorLabel.textColor = colors[rightColorIndex]
        rightColorLabel.text = titles[rightTitleIndex]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
