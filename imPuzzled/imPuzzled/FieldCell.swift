//
//  FieldCell.swift
//  imPuzzled
//
//  Created by Tom Williamson on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class FieldCell: UITableViewCell {

    @IBOutlet var fieldType: UILabel!
    @IBOutlet var fieldValue: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
