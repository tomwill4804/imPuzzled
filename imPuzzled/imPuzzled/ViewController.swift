//
//  ViewController.swift
//  imPuzzled
//
//  Created by Steve Graff on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

struct gameOptions {
    
    var width = 20
    var height = 20
    var words = 10
    var minLength = 4
    var maxLength = 8
    var capabilities = [String]()
    
}


class ViewController: UITableViewController,APIDataDelegate {
    
    var apidata: APIData!
    var gameOption: gameOptions!
    
    
    //
    //  get the capabilities of this game from the api
    //
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        gameOption = gameOptions()
        
        let url = "polar-savannah-54119.herokuapp.com/capabilities"
        apidata = APIData(request: url, delegate: self)
    }
    
    
    //
    //  back from the api so build the gameoptions struct
    //
    func gotAPIData(apidata: APIData) {
        
        if apidata.dictionary != nil {
            var newDesc = [String]()
            for item in (apidata.dictionary as? NSArray)! {
                if let dict = item as? Dictionary<String, AnyObject> {
                    if let name = dict["name"] {
                        newDesc.append(name as! String)
                    }
                }
            }
            gameOption.capabilities = newDesc
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if  segue.identifier == "showNewGame" {
            //let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let dvc = segue.destinationViewController as! NewGameViewController
            dvc.gameOption = self.gameOption
        }
        
    }

    
}
