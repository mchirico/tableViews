//
//  TableViewCell.swift
//  tv
//
//  Created by Michael Chirico on 9/28/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var label0: UILabel!
  @IBOutlet weak var text0: UITextField!
  
  @IBOutlet weak var label1: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
