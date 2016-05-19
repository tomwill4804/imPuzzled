//
//  PlayGameViewController.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/18/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    
    
    var game: Game!
    
    struct gridCell {
        
        var character: String
        var index: Int
        var label: UILabel
        
    }

    
    private var labelGrid: [[gridCell]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildLabels()

        
    }

    //
    //  build all the labels for the game
    //
    func buildLabels() {
        
        let chars = game.characters as! [String]
        let index = 0;
        
        for col:Int in 0...game.width-1 {
            var rowArray: [gridCell] = []
            for row:Int in 0...game.height-1 {
                let label = UILabel(frame: CGRectMake(CGFloat(20*col) + 40, CGFloat(row * 20) + 40,
                    20, 20))
                let gc = gridCell(character: chars[index], index: index, label: label)
                rowArray += [gc]
                self.view.addSubview(label)
            }
            labelGrid += rowArray
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
