//
//  ViewController.swift
//  SpyDetector
//
//  Created by Muratbek Bauyrzhan on 4/8/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Bronze: UIViewController {
    @IBOutlet var leftColorLabel: UILabel!
    @IBOutlet var rightColorLabel: UILabel!
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var countOfCorrectAnswers: UILabel!
    @IBOutlet var countOfWrongAnswers: UILabel!
    var correctAnswers = 0
    var wrongAnswers = 0
    
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
        
        countOfCorrectAnswers.text = "Correct: \(correctAnswers)"
        countOfWrongAnswers.text = "Wrong: \(wrongAnswers)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

