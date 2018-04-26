//
//  Gold.swift
//  EggToss
//
//  Created by Muratbek Bauyrzhan on 4/9/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Gold: UIViewController {
    
    @IBOutlet var eggImageView: UIImageView!
    @IBOutlet var brokenImageView: UIImageView!
    @IBOutlet var basketImageView: UIImageView!
    @IBOutlet var eggBackgroundView: UIView!
    @IBOutlet var gameOverView: UIView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var buttonView: UIView!
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        gameOverView.isHidden = true
        buttonView.isHidden = false
        score = 0
        lives = 5
        
        for case let imageView as UIImageView in
            eggBackgroundView.subviews {
                imageView.image = UIImage(named: "egg")
        }
        
        brokenImageView.isHidden = true
        throwEgg()
    }
    
    @IBAction func changePositionButtonPressed(_ sender: UIButton) {
        switch (sender.tag) {
        case 0:
            basketPosition = 0
            basketImageView.frame.origin.x = 26
        case 1:
            basketPosition = 1
            basketImageView.frame.origin.x = 119
        case 2:
            basketPosition = 2
            basketImageView.frame.origin.x = 214
        default:
            basketPosition = 1
            basketImageView.frame.origin.x = 119
        }
    }
    
    var eggPosition = 0
    var basketPosition = 1
    
    var timer = Timer()
    
    var lives = 5
    var score = 0
    
    var increaseSpeed: CGFloat = 10
    
    var superEggIsPresent = false
    
    var level: NSString!
    
    var basketImageViewPosAtY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        switch(level) {
            case "Standard":
                basketImageViewPosAtY = 325
            case "Hard":
                basketImageViewPosAtY = 250
            default:
                basketImageViewPosAtY = 390
        }
        
        basketImageView.frame.origin.y = basketImageViewPosAtY
        
        eggImageView.layer.cornerRadius = 5
        throwEgg()
    }
    
    func getInitialPosition() {
        eggPosition = Int(arc4random_uniform(3))
        switch (eggPosition) {
        case 0:
            eggImageView.frame.origin.x = 81
            eggImageView.frame.origin.y = 0
        case 1:
            eggImageView.frame.origin.x = 174
            eggImageView.frame.origin.y = 0
        case 2:
            eggImageView.frame.origin.x = 268
            eggImageView.frame.origin.y = 0
        default:
            eggImageView.frame.origin.x = 174
            eggImageView.frame.origin.y = 0
        }
    }
    
    func throwEgg() {
        if (lives > 0) {
            getInitialPosition()
            let eggIdentifier = arc4random_uniform(2)
            if (eggIdentifier == 0) {
                eggImageView.backgroundColor = .clear
                superEggIsPresent = false
            } else {
                eggImageView.backgroundColor = .orange
                superEggIsPresent = true
            }
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Bronze.changePosition), userInfo: nil, repeats: true)
        } else {
            gameOver()
        }
    }
    
    func changePosition() {
        eggImageView.frame.origin.y += increaseSpeed
        checkEgg()
    }
    
    func checkEgg() {
        if (eggImageView.frame.origin.y >= basketImageViewPosAtY) {
            if (eggPosition == basketPosition) {
                score += 1
                if superEggIsPresent {
                    if lives < 5 {
                        (eggBackgroundView.subviews[(eggBackgroundView.subviews.count-lives)-1] as! UIImageView).image = UIImage(named: "egg")
                        lives += 1
                        updateLife()
                    }
                }
                if (score%5 == 0) {
                    increaseSpeed += 5
                }
                timer.invalidate()
                throwEgg()
            } else {
                if (eggImageView.frame.origin.y >= 500) {
                    showBrokenEgg(position: eggPosition)
                    lives -= 1
                    updateLife()
                    timer.invalidate()
                    throwEgg()
                }
            }
        }
    }
    
    func showBrokenEgg(position: Int) {
        switch (position) {
        case 0:
            brokenImageView.frame.origin.x = 61
        case 1:
            brokenImageView.frame.origin.x = 154
        case 2:
            brokenImageView.frame.origin.x = 248
        default:
            brokenImageView.frame.origin.x = 154
        }
        brokenImageView.isHidden = false
    }
    
    func updateLife() {
        for case let (index, imageView as UIImageView) in
            eggBackgroundView.subviews.enumerated() {
                if(4 - index == lives) {
                    imageView.image = UIImage(named: "egg-broken")
                    break
                }
        }
    }
    
    func gameOver() {
        gameOverView.isHidden = false
        buttonView.isHidden = true
        scoreLabel.text = "\(score)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
