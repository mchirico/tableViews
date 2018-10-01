//
//  EditViewController.swift
//  tv
//
//  Created by Michael Chirico on 10/1/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textMsg: UITextField!
  
  var row=0
  var id=0
  var mainViewController:CheckListViewController?
  
  
  @IBAction func edit(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    
    if let mvc = mainViewController, let txt = textMsg.text  {
      mvc.m.update(id: id, msg: txt, row: row)
      mvc.m.populate()
      print("m: \(mvc.m.db)")
      mvc.tableView.reloadData()
    }
  }
  
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textMsg.text = mainViewController?.m.db[row].msg
    // Do any additional setup after loading the view.
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
