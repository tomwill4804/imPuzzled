//
//  Game.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation
import CoreData


class Game: NSManagedObject {
    
    
    //
    //  start a new game
    //
    func startGame(options: gameOptions) {
        
        width = options.width
        self.height = options.height
        self.words = options.words
        self.minLength = options.minLength
        self.maxLength = options.maxLength
        let curdate = NSDate().timeIntervalSince1970
        self.started = curdate
        self.lastUsed = curdate
        
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
