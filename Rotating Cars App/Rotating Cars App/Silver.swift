//
//  Silver.swift
//  Rotating Cars App
//
//  Created by Muratbek Bauyrzhan on 2/10/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Silver: UIViewController {
    
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var middleImageView: UIImageView!
    @IBOutlet var bottomImageView: UIImageView!
    @IBOutlet var rotateCarsUpButton: UIButton!
    @IBOutlet var rotateCarsDownButton: UIButton!
    
    @IBAction func onRotateCarsUpButtonPressed(_ sender: UIButton ) {
        let topImage = topImageView.image
        topImageView.image = middleImageView.image
        middleImageView.image = bottomImageView.image
        bottomImageView.image = topImage
    }
    
    @IBAction func onRotateCarsDownButtonPressed(_ sender: UIButton ) {
        let bottomImage = bottomImageView.image
        bottomImageView.image = middleImageView.image
        middleImageView.image = topImageView.image
        topImageView.image = bottomImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateCarsUpButton.layer.cornerRadius = 30
        rotateCarsDownButton.layer.cornerRadius = 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


