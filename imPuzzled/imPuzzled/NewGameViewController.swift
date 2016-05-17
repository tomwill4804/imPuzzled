//
//  NewGameViewController.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class NewGameViewController: UITableViewController {
    
    var gameOption: gameOptions!
    var fieldDict: [String:Int]! = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldDict["Width"] = gameOption.width
        fieldDict["Height"] = gameOption.height
        fieldDict["Words"] = gameOption.words
        fieldDict["Min Length"] = gameOption.minLength
        fieldDict["Max Length"] = gameOption.maxLength
  
    }


    // MARK: - Table view data source

    //
    //  two sections:
    //  the first is the list of field values
    //  the second in the list of capabilities
    //
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 2
    }

    //
    //  first section count is from field value dictionary
    //  second section count is from capabilities array
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        //
        //  first section uses custom cell that has a label and text field
        //
        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCellWithIdentifier("fieldCell", forIndexPath: indexPath) as! FieldCell
            
            cell.fieldType.text = Array(fieldDict.keys)[indexPath.row]
            let svalue = "\(Array(fieldDict.values)[indexPath.row])"
            cell.fieldValue.placeholder = svalue
            cell.fieldValue.keyboardType = .DecimalPad

            return cell
            
        }
        
            //
            //  second section uses standard cell with just a label
            //
            
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("capabilityCell", forIndexPath: indexPath)
            cell.textLabel?.text = gameOption.capabilities[indexPath.row]
            return cell
        }
        
     
    }
    
    
    //
    //  for second section flip the checkmark flag
    //
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                if cell.accessoryType == .Checkmark {
                    cell.accessoryType = .None
                } else {
                    cell.accessoryType = .Checkmark
                }
            }
        }
    }
    
    //
    //  set section title
    //
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Game Settings"
        }
        else {
            return "Choose atleast one option below"
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
