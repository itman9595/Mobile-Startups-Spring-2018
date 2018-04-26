//
//  GuessNumberViewController.swift
//  Akinator
//
//  Created by Muratbek Bauyrzhan on 2/11/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class GuessNumberViewController: UIViewController {
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lessButton: UIButton!
    @IBOutlet var biggerButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    
    var left = 0
    var right = 100
    var middle = 0
    
    @IBAction func onLessButtonPressed(_ sender: UIButton) {
        binarySearchStep(isRight: false)
    }
    
    @IBAction func onBiggerButtonPressed(_ sender: UIButton) {
        binarySearchStep(isRight: true)
    }
    
    @IBAction func onYesButtonPressed(_ sender: UIButton) {
        imageView.image = UIImage(named: "Illustration:Happy")
        lessButton.isHidden = true
        biggerButton.isHidden = true
        yesButton.isHidden = true
        backgroundView.isHidden = true
    }
    
    @IBAction func onRestartButtonPressed(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = main.instantiateViewController(withIdentifier: "mainVC")
        self.present(mainVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeGuess()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func makeGuess() {
        middle = (left + right) / 2
        numberLabel.text = "\(middle)"
    }
    
    func binarySearchStep(isRight: Bool) {
        if (isRight) {
            left = middle + 1
        } else {
            right = middle - 1
        }
        makeGuess()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
