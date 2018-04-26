//
//  modalWindow.swift
//  Quiz App
//
//  Created by Muratbek Bauyrzhan on 2/17/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class modalWindow: UIViewController {
    
    @IBOutlet var elapsedTime: UILabel!
    @IBOutlet var rightAnswers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let data = defaults.dictionary(forKey: "pushedData") as! Dictionary<String, String>
        elapsedTime.text = data["Elapsed Time"]
        rightAnswers.text = data["Amount of Right Answers"]
    }
    
}
