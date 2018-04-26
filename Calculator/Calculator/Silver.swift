//
//  Silver.swift
//  Calculator
//
//  Created by Muratbek Bauyrzhan on 2/21/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Silver: UIViewController {
    
    var firstNumber: String = ""
    var secondNumber: String = ""
    var operation: String = ""
    
    @IBOutlet var calculationLabel: UILabel!
    
    func divideBySpaces(text: String?) {
        if let _ = text {
            var s = text!
            s = s.replacingOccurrences(of: " ", with: "")
            if s.count>3 {
                var i = s.count
                while i>=0 {
                    if i%3 == 1 {
                        s.insert(" ", at: s.index(s.endIndex, offsetBy: -(i/3*3)))
                    }
                    i -= 1
                }
            }
            calculationLabel.text = s
        }
    }
    
    @IBAction func onDigitButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == "0" {
            if calculationLabel.text != "0" {
                calculationLabel.text! += sender.currentTitle!
            }
        } else {
            calculationLabel.text! += sender.currentTitle!
        }
        divideBySpaces(text: calculationLabel.text)
    }
    
    @IBAction func onOperationButtonPressed(_ sender: UIButton) {
        if calculationLabel.text != "" {
            calculationLabel.text! = calculationLabel.text!.replacingOccurrences(of: " ", with: "")
            firstNumber = calculationLabel.text!
        }
        calculationLabel.text = ""
        operation = sender.currentTitle!
    }
    
    @IBAction func onResultButtonPressed(_ sender: UIButton) {
        calculationLabel.text! = calculationLabel.text!.replacingOccurrences(of: " ", with: "")
        secondNumber = calculationLabel.text!
        var result: Int?
        switch operation {
            case "/":
                if Int(secondNumber) == 0 {
                    calculationLabel.text = "Error"
                } else {
                    result = Int(firstNumber)! / Int(secondNumber)!
                }
            case "x":
                result = Int(firstNumber)! * Int(secondNumber)!
            case "-":
                result = Int(firstNumber)! - Int(secondNumber)!
            case "+":
                result = Int(firstNumber)! + Int(secondNumber)!
            case "%":
                result = Int(firstNumber)! % Int(secondNumber)!
            default:
                result = 0
        }
        
        if let result = result {
            divideBySpaces(text: String(result))
        }
    }
    
    @IBAction func onClearButtonPressed(_ sender: UIButton) {
        firstNumber = ""
        secondNumber = ""
        operation = ""
        calculationLabel.text = ""
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
