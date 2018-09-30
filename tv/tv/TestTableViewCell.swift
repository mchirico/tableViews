//
//  TestTableViewCell.swift
//  tv
//
//  Created by Michael Chirico on 9/30/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var label0: UILabel!
  
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

