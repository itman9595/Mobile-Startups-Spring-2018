//
//  Gold.swift
//  Switch Color App
//
//  Created by Muratbek Bauyrzhan on 2/10/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Gold: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var switchColorButton: UIButton!
    
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        var tempColor = backgroundView.backgroundColor
        backgroundView.backgroundColor = switchColorButton.backgroundColor
        switchColorButton.backgroundColor = tempColor
        tempColor = backgroundView.backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
