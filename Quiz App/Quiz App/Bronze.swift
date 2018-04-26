//
//  ViewController.swift
//  Quiz App
//
//  Created by Muratbek Bauyrzhan on 2/17/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Bronze: UIViewController {

    @IBOutlet var questionIndexLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var submitButton: UIButton!
    
    var questions = [
        ["1", "Кто является создателем социальной сети Facebook?", "mark", "bill", "ilon", "pavel"],
        ["2", "Какой мессенджер является самым популярным в мире?", "telegram", "facebook", "whatsapp", "talk"],
        ["3", "Какой из предложенных логотипов принадлежит файловому обменнику?", "apple", "dropbox", "huawei", "evernote"],
        ["4", "Какое из предложенных программных обеспечении, создает виртуальное пространство для iOS при тестировании мобильного приложения?", "emulator", "microsoft_emulator", "calculator", "simulator"],
        ["5", "Какая программа является детищем \"Павла Дурова\"?", "vk", "fb", "youtube", "twitter"]
    ]
    
    var answers = ["mark", "whatsapp", "dropbox", "simulator", "vk"]
    
    var index = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.button1.layer.cornerRadius = 8
        self.button1.layer.masksToBounds = true
        self.button2.layer.cornerRadius = 8
        self.button2.layer.masksToBounds = true
        self.button3.layer.cornerRadius = 8
        self.button3.layer.masksToBounds = true
        self.button4.layer.cornerRadius = 8
        self.button4.layer.masksToBounds = true
        
        self.submitButton.isEnabled = false
        getQuestions()
    }
    
    func getQuestions() {
        self.questionIndexLabel.text = "Вопрос \(self.questions[index][0])"
        self.questionLabel.text = self.questions[index][1]
        self.button1.setBackgroundImage(UIImage(named: self.questions[index][2]), for: .normal)
        self.button2.setBackgroundImage(UIImage(named: self.questions[index][3]), for: .normal)
        self.button3.setBackgroundImage(UIImage(named: self.questions[index][4]), for: .normal)
        self.button4.setBackgroundImage(UIImage(named: self.questions[index][5]), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clicked() {
        self.submitButton.isEnabled = true
        self.submitButton.setTitle("Продолжить", for: .normal)
        self.button1.isEnabled = false
        self.button2.isEnabled = false
        self.button3.isEnabled = false
        self.button4.isEnabled = false
    }
    
    func clear() {
        self.button1.layer.borderWidth = 0
        self.button1.layer.borderColor = UIColor.clear.cgColor
        self.button2.layer.borderWidth = 0
        self.button2.layer.borderColor = UIColor.clear.cgColor
        self.button3.layer.borderWidth = 0
        self.button3.layer.borderColor = UIColor.clear.cgColor
        self.button4.layer.borderWidth = 0
        self.button4.layer.borderColor = UIColor.clear.cgColor
        
        self.submitButton.isEnabled = false
        self.submitButton.setTitle("Выберите вариант", for: .normal)
        
        self.button1.isEnabled = true
        self.button2.isEnabled = true
        self.button3.isEnabled = true
        self.button4.isEnabled = true
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        if self.questions[index][sender.tag] == self.answers[index] {
            sender.layer.borderWidth = 3
            sender.layer.borderColor = UIColor.green.cgColor
            self.total += 1
        } else {
            sender.layer.borderWidth = 3
            sender.layer.borderColor = UIColor.red.cgColor
        }
        self.clicked()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        self.clear()
        
        if self.index < questions.count-1 {
            self.index += 1
            self.getQuestions()
        } else {
            let alert = UIAlertController(title: "Финиш", message: "Ваш результат: \(self.total)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.index = 0
                self.total = 0
                self.getQuestions()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
