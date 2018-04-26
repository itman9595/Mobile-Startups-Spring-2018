//
//  Bronze.swift
//  Rotating Cars App
//
//  Created by Muratbek Bauyrzhan on 2/10/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Bronze: UIViewController {

    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    @IBOutlet var rotateCarsButton: UIButton!
    
    @IBAction func onRotateCarsButtonPressed(_ sender: UIButton ) {
        let firstImage = firstImageView.image
        firstImageView.image = secondImageView.image
        secondImageView.image = thirdImageView.image
        thirdImageView.image = fourthImageView.image
        fourthImageView.image = firstImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateCarsButton.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

