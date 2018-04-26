//
//  LevelTableViewController.swift
//  EggToss
//
//  Created by Muratbek Bauyrzhan on 4/9/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class LevelTableViewController: UITableViewController {
    
    let levels = ["Easy", "Standard", "Hard"]
    var level: NSString!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let indexPath: NSIndexPath = tableView.indexPathForSelectedRow! as NSIndexPath
            level = levels[indexPath.row] as NSString
            let dest = segue.destination as! Gold
            dest.level = level
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = levels[indexPath.row]
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
