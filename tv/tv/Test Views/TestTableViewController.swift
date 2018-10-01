//
//  TestViewController.swift
//  tv
//
//  Created by Michael Chirico on 9/30/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
  
  
  let m = Model(table: "testTable.sqlite")
  var rowHeight=100
  
  
  
  
  
  @IBAction func AddItem(_ sender: UIBarButtonItem) {
    
    
  }
  
  @IBAction func EditItems(_ sender: UIBarButtonItem) {
    
    if let e =  self.navigationItem.rightBarButtonItems?[1] {
      if e.title == "Edit" {
        self.tableView.isEditing = true
        e.title = "Done"
      } else {
        e.title = "Edit"
        self.tableView.isEditing = false
      }
    }
    
  }
  
  var count = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //sb.createTable()
    m.create()
    m.populate()
    
    
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return m.count()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TestID", for: indexPath)
    
    if let tvc = cell as? TestTableViewCell {
      tvc.label0.text = "\(m.db[indexPath.row].msg)"
      
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(" \(indexPath)")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TestID", for: indexPath)
    
    count+=1
    
    if let tvc = cell as? TableViewCell {
      tvc.label0.text = "msg: \(m.db[indexPath.row].msg)"
      
    }
    
    if Int(tableView.rowHeight) == rowHeight {
      tableView.rowHeight = 250
    } else {
      tableView.rowHeight = CGFloat(rowHeight)
    }
    
    tableView.reloadData()
    
    print("\n\n*************\n\n \(indexPath.row) \n\n****************\n\n")
    
    jump(row: indexPath.row)
    //jumpTVC2()
    
  }
  
  
  func jump(row: Int) {
    
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestEdit") as? TestEditViewController
    
    vc?.row = row
    vc?.id = m.db[row].id
    vc?.mainViewController = self
    
    self.navigationController?.pushViewController(vc!, animated: true)
    
  }
  
  func jumpTVC2() {
    
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestTVC2") as? TestTVC2
    self.navigationController?.pushViewController(vc!, animated: true)
    
  }
  
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
    m.swap(from: sourceIndexPath[1], to: destinationIndexPath[1])
    m.populate()
    print("here moveRowAt: \(sourceIndexPath[1]),\(destinationIndexPath[1])")
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      print("Deleted: \(indexPath[1])")
      m.delIndex(row: indexPath[1])
      m.populate()
      tableView.reloadData()
      
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.destination is TestAddViewController
    {
      let vc = segue.destination as? TestAddViewController
      vc?.data = "Arthur Dent"
      vc?.mainViewController = self
    }
  }
  
  
}










