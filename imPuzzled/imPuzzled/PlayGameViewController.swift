//
//  PlayGameViewController.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/18/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    
    @IBOutlet var recognizer: UIPanGestureRecognizer!
    
    var game: Game!
    
    private var labelGrid: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildLabels()

        
    }

    //
    //  build all the labels for the game
    //
    func buildLabels() {
        
        let chars = game.characters as! [String]
        var index = 0;
        
        for row:Int in 0...game.height-1 {
            for col:Int in 0...game.width-1 {
                let label = UILabel(frame: CGRectMake(CGFloat(col * 20) + 40, CGFloat(row * 20) + 80,
                    20, 20))
                label.text = chars[index]
                label.tag = index
                self.view.addSubview(label)
                labelGrid += [label]
                index += 1
                print(label.frame)
            }
        }
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let tapPoint = recognizer.locationInView(view)
        
        if recognizer.state == .Began {
            
        }
       
        if recognizer.state == .Changed {
            print(view.hitTest(tapPoint, withEvent: nil))
            if let label = view.hitTest(tapPoint, withEvent: nil) as? UILabel {
                label.textColor = UIColor.redColor()
            }
        }
      
        if recognizer.state == .Ended {
          
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
