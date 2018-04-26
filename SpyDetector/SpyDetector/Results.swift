//
//  Results.swift
//  SpyDetector
//
//  Created by Muratbek Bauyrzhan on 4/8/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Results: UITableViewController {
    
    var resultsOfPlayers: [(username: NSString, correct: Int32, wrong: Int32)]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let databasePath = dirPaths[0].appendingPathComponent("results.db").path as NSString
        
        let resultsDB = FMDatabase(path: databasePath as String)
        
        if resultsDB.open() {
            let querySQL = "SELECT * FROM RESULTS"
            
            let results:FMResultSet? = resultsDB.executeQuery(querySQL, withArgumentsIn: [])
            
            while results?.next() == true {
                let stats: (username: NSString, correct: Int32, wrong: Int32) = (
                    results?.string(forColumn: "USERNAME") as! NSString,
                    (results?.int(forColumn: "CORRECT"))!,
                    (results?.int(forColumn: "WRONG"))!
                )
                resultsOfPlayers.append(stats)
            }
            resultsDB.close()
            resultsOfPlayers.sort { $0.correct > $1.correct }
            tableView.reloadData()
        } else {
            print("Error: \(resultsDB.lastErrorMessage())")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsOfPlayers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "Cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        let username = resultsOfPlayers[indexPath.row].username
        let correct = resultsOfPlayers[indexPath.row].correct
        let wrong = resultsOfPlayers[indexPath.row].wrong
        
        cell?.textLabel?.text = username as String
        cell?.detailTextLabel?.text = "Correct: \(correct), Wrong: \(wrong)"
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
