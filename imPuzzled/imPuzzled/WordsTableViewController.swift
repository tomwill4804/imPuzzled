//
//  WordsTableViewController.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class WordsTableViewController: UITableViewController {
    
    var game: Game!
    var words:[[String: AnyObject]]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tbvc = self.tabBarController as! PlayGameTabViewController
        game = tbvc.game

    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        words = game.words as! [[String: AnyObject]]
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return words.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let dict = words[indexPath.row]
        let wtext = dict["word"]
        cell.textLabel?.text = wtext as? String
        
        let found = dict["found"] as! Bool
        if found {
            cell.accessoryType = .Checkmark
        }
        
        return cell
        
    }

}