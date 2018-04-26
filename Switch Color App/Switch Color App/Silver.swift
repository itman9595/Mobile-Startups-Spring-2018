//
//  Silver.swift
//  Switch Color App
//
//  Created by Muratbek Bauyrzhan on 2/10/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Silver: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var switchColorButton: UIButton!
    
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        
        let randomGreen: CGFloat = CGFloat(drand48())
        backgroundView.backgroundColor = UIColor(red: 0.0, green: randomGreen, blue: 0.0, alpha: 1.0)
        
        let randomBlue: CGFloat = CGFloat(drand48())
        switchColorButton.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: randomBlue, alpha: 1.0)
        
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
