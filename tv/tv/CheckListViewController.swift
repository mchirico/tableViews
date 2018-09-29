//
//  ViewController.swift
//  tv
//
//  Created by Michael Chirico on 9/27/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class CheckListViewController:  UITableViewController {
  @IBAction func AddItem(_ sender: UIBarButtonItem) {
    
    let sb = SqliteBroker()
    sb.myStart()
  }
  
  var count = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListID", for: indexPath)
    
    
    
    if let tvc = cell as? TableViewCell {
      tvc.label0.text = "stuff: \(indexPath.row+count)"
      tvc.text0.text = " \(indexPath.row+count)"
      tvc.label1.text = ""
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(" \(indexPath)")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListID", for: indexPath)
    
    
    count+=1
    
    if let tvc = cell as? TableViewCell {
      tvc.label0.text = "stuff: \(indexPath.row)"
      tvc.text0.text = " \(indexPath.row)"
      tvc.label1.text = "s"
    }
    
    tableView.reloadData()
    
  }
}

