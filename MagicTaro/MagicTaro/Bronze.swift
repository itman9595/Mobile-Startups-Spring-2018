//
//  ViewController.swift
//  MagicTaro
//
//  Created by Muratbek Bauyrzhan on 2/18/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Bronze: UIViewController {

    @IBOutlet var button: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var jobPic: UIImageView!
    
    var predictions = ["Архитектор", "Пилот", "Спасатель", "Кондитер", "Генетик", "Пожарный", "Космонавт", "Хирург", "Врач", "Следователь", "Астроном", "Художник", "Режиссер", "Исследователь", "Дизайнер", "Инженер", "Видеооператор", "Программист", "Повар", "Реаниматолог", "Эколог", "Каскадер", "Актёр", "Прокурор", "Химик", "Кинолог", "Звукорежиссер", "Геофизик", "Эксперт", "Продюсер", "Композитор", "Руководитель", "Лаборант", "Певец", "Водолаз", "Бармен", "Географ", "Пекарь", "Фотограф", "Физик", "Винодел", "Ювелир", "Судья", "Скульптор", "Спичрайтер", "Стилист", "Сценарист", "Татуировщик", "Фотомодель", "Хореограф", "Автогонщик", "Драпировщик", "Каменщик", "Картограф", "Крановщик", "Маляр", "Мастер", "Машинист", "Металлург", "Монтажник", "Моторист", "Наладчик", "Облицовщик", "Отделочник", "Плотник", "Прораб", "Проходчик", "Радиомеханик", "Ремонтник", "Рихтовщик", "Сантехник", "Сварщик", "Слесарь", "Сталевар", "Столяр", "Строитель", "Технолог", "Токарь", "Фрезеровщик", "Часовщик", "Шахтер", "Швея", "Шлифовщик", "Штукатур", "Электрик", "Президент"]
    
    var jobImages = ["architector", "pilot", "savior", "confectioner", "genetic", "fireman", "cosmonaut", "surgeon",
                     "doctor", "investigator", "astronomer", "artist", "director", "researcher", "designer", "engineer",
                     "video operator", "programmer", "cook", "reanimatologist", "ecologist", "stuntman", "actor", "prosecutor", "chemist", "cynologist", "sound producer", "geophysicist", "expert", "producer",
                     "composer", "manager", "laboratory assistant", "singer", "diver", "barmen", "geographer",
                     "baker", "photographer", "physicist", "wine-maker", "jeweller", "judge", "sculptor", "speech writer",
                     "stylist", "scriptwriter", "tattooist", "photo model", "choreographer", "race-driver", "upholsterer",
                     "bricklayer", "cartographer", "crane-operator", "paper-hanger", "craftsman", "machinist", "metallurgist", "rigger", "motor-mechanic", "adjuster", "facing worker", "trowel man",
                     "carpenter", "foreman", "drift miner", "radio engineer", "repairman", "aligner", "plumber",
                     "welder", "metalworker", "steel founder", "joiner", "builder", "technologist", "turner", "milling-machine operator", "watchmaker", "miner", "seamstress", "grinder", "plasterer", "electrician",
                     "president"]
    
    var timer = Timer.init()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.button.layer.borderWidth = 2
        self.button.layer.borderColor = UIColor.white.cgColor
        self.button.setTitle("СТАРТ", for: .normal)
        
        self.titleLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        if self.button.titleLabel?.text == "СТАРТ" {
            self.button.setTitle("СТОП", for: .normal)
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changePrediction), userInfo: nil, repeats: true)
        } else {
            self.timer.invalidate()
            self.button.setTitle("СТАРТ", for: .normal)
        }
    }
    
    @objc func changePrediction() {
        self.titleLabel.text = self.predictions[self.index]
        self.jobPic.image = UIImage(named: jobImages[self.index])
        self.index += 1
        if self.index == self.predictions.count {
            self.index = 0
        }
    }
    
}
