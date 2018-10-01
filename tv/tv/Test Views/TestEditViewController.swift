//
//  TestEditViewController.swift
//  tv
//
//  Created by Michael Chirico on 10/1/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class TestEditViewController: UIViewController {
  
  
  @IBOutlet weak var labelMSG: UILabel!
  
  @IBOutlet weak var textMsg: UITextField!
  
  var row=0
  var id=0
  var mainViewController:TestTableViewController?
  
  
  @IBAction func Cancel(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func Update(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    
    if let mvc = mainViewController, let txt = textMsg.text  {
      mvc.m.update(id: id, msg: txt, row: row)
      mvc.m.populate()
      print("m: \(mvc.m.db)")
      mvc.tableView.reloadData()
    }
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    textMsg.text = mainViewController?.m.db[row].msg
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
