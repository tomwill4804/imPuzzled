//
//  Game.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation
import CoreData


class Game: NSManagedObject,APIDataDelegate {
    
    private var gameReady: ((Game) -> Void)!
    private var options: gameOptions!
    var error: String? = nil
    
    var apidata: APIData!
    
    //
    //  build a new game
    //
    func buildGame(options: gameOptions) {
        
        self.options = options
        
        width = findSetting("Width")
        height = findSetting("Height")
        wordCount = findSetting("Words")
        minLength = findSetting("Min Length")
        maxLength = findSetting("Max Length")
        
    }
    
    //
    //  find setting value 
    //
    func findSetting(name: String) -> Int32 {
        
        for setting in options.settings {
            if setting.name == name {
                return setting.value
            }
        }
        return 0
    }
    
    
    //
    //  start a new game
    //
    func startGame(whenReady: ((Game) -> Void)) {
        
        gameReady = whenReady
        
        //
        //  build dictionary of values to send to game builder
        //
        var dict : [String:AnyObject] = [:]
        
        dict["width"] = Int(width)
        dict["height"] = Int(height)
        dict["numberOfWords"] = Int(wordCount)
        dict["minLength"] = Int(minLength)
        dict["maxLength"] = Int(maxLength)
        
        var cap : [String] = []
        for capability in options.capabilities {
            
            if capability["used"] as! Bool == true {
                cap.append(capability["keyword"] as! String)
            }
        }
        dict["capabilities"] = cap
        
        //
        //  convert dictionary to json data 
        //
        var json = NSData.init()
        do {
            json = try NSJSONSerialization.dataWithJSONObject(dict, options:[])
            let jsonString = NSString(data: json, encoding: NSUTF8StringEncoding)! as String
            print(jsonString)
        }
        catch {
        }
        
        //
        //  issue api request
        //
        let url = "polar-savannah-54119.herokuapp.com/puzzle"
        apidata = APIData(request: url, delegate: self, json: json)

    }
    
    //
    //  back from the api so build the game
    //
    func gotAPIData(apidata: APIData) {
        
        if apidata.errorText != nil {
            error = apidata.errorText
            gameReady(self)
        }
        
        if apidata.dictionary != nil {
            
            let curdate = NSDate().timeIntervalSince1970
            started = curdate
            lastUsed = curdate
            
            charactersAttr = []
            var char: [String] = []
            
            let charArray = apidata.dictionary!["puzzle"] as? [[String]]
            for row in charArray! {
                char = char + row
            }
            
            characters = char as [String]
            charactersAttr = [String](count: char.count, repeatedValue: " ")
            
            let wordArray = apidata.dictionary!["words"] as? [[String:AnyObject]]
            var words = [[String: AnyObject]]()
            for word in wordArray! {
                print(word)
                let wtext = word["word"]!
                //print(wtext)
                words += [["word":wtext, "found": false]]
            }
            
            wordCount = Int32(words.count)
            foundWordCount = 0
            self.words = words
            
            doSave()
            
            gameReady(self)
            
        }
    }

    
    
    //
    //  save this game
    //
    func doSave() {
        
        if self.managedObjectContext!.hasChanges {
            do {
                try managedObjectContext!.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}
