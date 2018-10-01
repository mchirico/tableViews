//
//  TestAddViewController.swift
//  tv
//
//  Created by Michael Chirico on 9/30/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class TestAddViewController: UIViewController {

  var data=""
  var mainViewController:TestTableViewController?
  
  @IBOutlet weak var msgTxt: UITextField!
  
  @IBAction func Cancel(_ sender: UIBarButtonItem) {
     navigationController?.popViewController(animated: true)
  }
  
  @IBAction func Add(_ sender: UIBarButtonItem) {
     navigationController?.popViewController(animated: true)
    
    if let mvc = mainViewController, let txt = msgTxt.text  {
      mvc.m.insert(msg: txt)
      mvc.m.populate()
      mvc.tableView.reloadData()
    }
  }
  
  
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
