//
//  Game+CoreDataProperties.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Game {

    @NSManaged var started: NSTimeInterval
    @NSManaged var lastUsed: NSTimeInterval
    @NSManaged var name: String?
    @NSManaged var width: Int32
    @NSManaged var height: Int32
    @NSManaged var words: Int32
    @NSManaged var minLength: Int32
    @NSManaged var maxLength: Int32
    @NSManaged var characters: NSObject?
    @NSManaged var foundWords: NSObject?

}
