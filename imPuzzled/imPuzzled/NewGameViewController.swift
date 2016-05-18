//
//  NewGameViewController.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

class NewGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameOption: gameOptions!
    var game: Game?
    var managedObjectContext: NSManagedObjectContext!
    
    var fieldDict: [(name: String, value: Int32)] = []
    
    //
    //  build a list of field names / values to be used in first section
    //  of the table
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldDict += [(name:"Width", value:gameOption.width)]
        fieldDict += [(name:"Height", value:gameOption.height)]
        fieldDict += [(name:"Words", value:gameOption.words)]
        fieldDict += [(name:"Min Length", value:gameOption.minLength)]
        fieldDict += [(name:"Max Length", value:gameOption.maxLength)]
  
    }


    // MARK: - Table view data source

    //
    //  two sections:
    //  the first is the list of field values
    //  the second in the list of capabilities
    //
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 2
    }

    //
    //  first section count is from field value dictionary
    //  second section count is from capabilities array
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return fieldDict.count
        }
        else {
            return gameOption.capabilities.count
        }
        
    }
    

   
    //
    //  build right cell
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        //
        //  first section uses custom cell that has a label and text field
        //
        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCellWithIdentifier("fieldCell", forIndexPath: indexPath) as! FieldCell
            
            cell.fieldType.text = fieldDict[indexPath.row].name
            let svalue = "\(fieldDict[indexPath.row].value)"
            cell.fieldValue.placeholder = svalue
            cell.fieldValue.keyboardType = .NumberPad

            return cell
            
        }
        
            //
            //  second section uses standard cell with just a label
            //
            
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("capabilityCell", forIndexPath: indexPath)
            cell.textLabel?.text = gameOption.capabilities[indexPath.row].name
            
            return cell
        }
        
     
    }
    
    
    //
    //  for second section flip the checkmark flag
    //
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            self.view.endEditing(true)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                if cell.accessoryType == .Checkmark {
                    cell.accessoryType = .None
                    gameOption.capabilities[indexPath.row].used = false
                } else {
                    cell.accessoryType = .Checkmark
                    gameOption.capabilities[indexPath.row].used = true
                }
            }
        }
    }
    
    //
    //  set section title
    //
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Game Settings"
        }
        else {
            return "Choose atleast one option below"
        }
        
    }
    
    @IBAction func playButtonPushed(sender: AnyObject) {
        
        let entity = NSEntityDescription.entityForName("Game", inManagedObjectContext: self.managedObjectContext)
        self.game = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: nil) as? Game
        self.game?.buildGame(gameOption)
        performSegueWithIdentifier("unwindNewGame", sender: self)
        
    }
    
}
