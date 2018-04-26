//
//  Gold.swift
//  SpyDetector
//
//  Created by Muratbek Bauyrzhan on 4/8/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Gold: UIViewController {
    @IBOutlet var leftColorLabel: UILabel!
    @IBOutlet var rightColorLabel: UILabel!
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var noBtn: UIButton!
    @IBOutlet var yesBtn: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startPauseButton: UIButton!
    var timer = Timer()
    var seconds: Int = 0
    var correctAnswers = 0
    var wrongAnswers = 0
    var usernameAlert: UIAlertController!
    var username: NSString = ""
    var databasePath = NSString()
    var usernameAlertIsShown: Bool!
    
    func createDatabase() {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("results.db").path as NSString
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            let resultsDB = FMDatabase(path: databasePath as String)
            
            if resultsDB == nil {
                print("Error: \(resultsDB.lastErrorMessage())")
            }
            
            if resultsDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS RESULTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, CORRECT INTEGER, WRONG INTEGER)"
                if !resultsDB.executeStatements(sql_stmt) {
                    print("Error: \(resultsDB.lastErrorMessage())")
                }
                resultsDB.close()
            } else {
                print("Error: \(resultsDB.lastErrorMessage())")
            }
        }
    }
    
    func updateDatabase() {
        var resultsDB = FMDatabase(path: databasePath as String)
        
        if resultsDB.open() {
            
            let querySQL = "SELECT CORRECT, WRONG FROM RESULTS WHERE USERNAME = '\(username)'"
            
            let existingElement:FMResultSet? = resultsDB.executeQuery(querySQL, withArgumentsIn: [])
            
            var updateSQL = "UPDATE RESULTS SET CORRECT = \(correctAnswers), WRONG = \(wrongAnswers) WHERE USERNAME = '\(username)'"
            
            if(existingElement?.next() == true) {
                resultsDB.close()
            } else {
                print("NOT FOUND")
                resultsDB.close()
                resultsDB = FMDatabase(path: databasePath as String)
                updateSQL = "INSERT INTO RESULTS (USERNAME, CORRECT, WRONG) VALUES ('\(username)', '\(correctAnswers)', '\(wrongAnswers)')"
            }
            
            if resultsDB.open() {
                let result = resultsDB.executeUpdate(updateSQL, withArgumentsIn: [])
                
                if result {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Results") as? Results
                    {
                        resultsDB.close()
                        correctAnswers = 0
                        wrongAnswers = 0
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            
        } else {
            print("Error: \(resultsDB.lastErrorMessage())")
        }
    }
    
    @IBAction func onStartPauseButtonPressed(_ sender: Any) {
        if(startPauseButton.currentTitle! == "Start") {
            timerLabel.text = "00:00"
            if !usernameAlertIsShown {
                self.present(usernameAlert, animated: true, completion: nil)
            } else {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Silver.increaseSeconds), userInfo: nil, repeats: true)
            }
            noBtn.isEnabled = true
            yesBtn.isEnabled = true
            leftColorLabel.isHidden = false
            rightColorLabel.isHidden = false
            noBtn.setTitleColor(UIColor.white, for: .normal)
            yesBtn.setTitleColor(UIColor.white, for: .normal)
            startPauseButton.setTitle("Pause", for: .normal)
        } else {
            noBtn.isEnabled = false
            yesBtn.isEnabled = false
            leftColorLabel.isHidden = true
            rightColorLabel.isHidden = true
            noBtn.setTitleColor(UIColor.gray, for: .normal)
            yesBtn.setTitleColor(UIColor.gray, for: .normal)
            timer.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
            seconds = 0
            statusImageView.isHidden = true
            updateDatabase()
        }
    }
    
    @objc func increaseSeconds() {
        seconds += 1
        timerLabel.text = String(format: "%02d", seconds / 60) + ":" + String(format : "%02d", seconds % 60)
    }
    
    @IBAction func onNoButtonPressed(_ sender: UIButton) {
        if(leftTitleIndex != rightColorIndex) {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "success")
            correctAnswers += 1
        } else {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "fail")
            wrongAnswers += 1
        }
        
        setupViews()
    }
    
    @IBAction func onYesButtonPressed(_ sender: UIButton) {
        if(leftTitleIndex == rightColorIndex) {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "success")
            correctAnswers += 1
        } else {
            statusImageView.isHidden = false
            statusImageView.image = UIImage(named: "fail")
            wrongAnswers += 1
        }
        
        setupViews()
    }
    
    var leftColorIndex = 0
    var leftTitleIndex = 0
    
    var rightColorIndex = 0
    var rightTitleIndex = 0
    
    var colors = [UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.red, UIColor.yellow, UIColor.cyan, UIColor.brown]
    var titles = ["Black", "Green", "Purple", "Orange", "Red", "Yellow", "Cyan", "Brown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        leftView.layer.cornerRadius = 8
        rightView.layer.cornerRadius = 8
        
        leftView.layer.shadowOpacity = 0.5
        leftView.layer.shadowOffset = CGSize(width: 0, height: 2)
        leftView.layer.shadowRadius = 10
        leftView.layer.shadowColor = UIColor.black.cgColor
        
        rightView.layer.shadowOpacity = 0.5
        rightView.layer.shadowOffset = CGSize(width: 0, height: 2)
        rightView.layer.shadowRadius = 10
        rightView.layer.shadowColor = UIColor.black.cgColor
        
        createDatabase()
        
        usernameAlert = UIAlertController(title: "Enter your username, please", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        usernameAlert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Username"
            textField.keyboardType = UIKeyboardType.default
            textField.addTarget(self.usernameAlert, action: #selector(self.usernameAlert.textDidChangeInLoginAlert), for: .editingChanged)
        })
        
        let submitUsernameAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { alert -> Void in
            guard let user = self.usernameAlert.textFields![0].text
            else {
                return
            }
            self.username = user as NSString
            self.usernameAlertIsShown = true
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Silver.increaseSeconds), userInfo: nil, repeats: true)
        })
        
        submitUsernameAction.isEnabled = false
        usernameAlert.addAction(submitUsernameAction)
        
        usernameAlertIsShown = false
        
        setupViews()
    }
    
    func setupViews() {
        leftColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        leftTitleIndex = Int(arc4random_uniform(UInt32(titles.count)))
        
        rightColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        rightTitleIndex = Int(arc4random_uniform(UInt32(titles.count)))
        
        leftColorLabel.textColor = colors[leftColorIndex]
        leftColorLabel.text = titles[leftTitleIndex]
        
        rightColorLabel.textColor = colors[rightColorIndex]
        rightColorLabel.text = titles[rightTitleIndex]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// CHECK IF USERNAME IS EMPTY

extension UIAlertController {
    func isValidUsername(_ username: NSString) -> Bool {
        return username.length > 0 && username.rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
    func textDidChangeInLoginAlert() {
        if let username = textFields![0].text as NSString?, let action = actions.last {
            action.isEnabled = isValidUsername(username)
        }
    }
}
