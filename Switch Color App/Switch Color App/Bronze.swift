//
//  ViewController.swift
//  Switch Color App
//
//  Created by Muratbek Bauyrzhan on 1/22/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Bronze: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var switchColorButton: UIButton!
    
    func getRandomRGB() -> (CGFloat, CGFloat, CGFloat) {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        return (randomRed, randomGreen, randomBlue)
    }
    
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        var (randomRed, randomGreen, randomBlue) = getRandomRGB()
        backgroundView.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        (randomRed, randomGreen, randomBlue) = getRandomRGB()
        switchColorButton.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
