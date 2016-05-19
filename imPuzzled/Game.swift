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
    var apidata: APIData!
    
    //
    //  build a new game
    //
    func buildGame(options: gameOptions) {
        
        self.options = options
        
        self.width = findSetting("Width")
        self.width = findSetting("Height")
        self.width = findSetting("Words")
        self.width = findSetting("Min Length")
        self.width = findSetting("Max Length")
        
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
        
        self.gameReady = whenReady
        let url = "polar-savannah-54119.herokuapp.com/capabilities"
        apidata = APIData(request: url, delegate: self)
        
    }
    
    //
    //  back from the api so build the game
    //
    func gotAPIData(apidata: APIData) {
        
        if apidata.dictionary != nil {
            
            let curdate = NSDate().timeIntervalSince1970
            self.started = curdate
            self.lastUsed = curdate
            
            self.foundWords = []
            self.unfoundWords = []
            self.charactersAttr = []
            self.characters = []
            
            let char = "xxcat" +
                "hixxx" +
                "abcde" +
                "xxgod" +
                "cbyex"
            
            self.width = 5
            self.height = 5
            self.characters = Array(char.characters.map { String($0) })
            self.charactersAttr = [String](count: char.characters.count, repeatedValue: " ")
            self.unfoundWords = ["cat","hi","dog","bye"]
            self.doSave()
            
            self.gameReady(self)
            
        }
    }

    
    
    //
    //  save this game
    //
    func doSave() {
        
        if self.managedObjectContext!.hasChanges {
            do {
                try self.managedObjectContext!.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}
