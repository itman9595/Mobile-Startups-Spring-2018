//
//  ViewController.swift
//  MagicTaro
//
//  Created by Muratbek Bauyrzhan on 2/19/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let topics = ["профессия", "искусство", "технология", "наука"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = topics[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let destination = segue.destination as? Gold
            destination?.topic = topics[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}
