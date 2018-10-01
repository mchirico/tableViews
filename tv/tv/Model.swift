//
//  Model.swift
//  tv
//
//  Created by Michael Chirico on 9/29/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class Model {
  
  let sb = SqliteBroker()
  var table: String
  
  var db =   [SqliteBroker.Result]()
  var dblog =  [SqliteBroker.Result]()
  
  init(table: String = "tv.sqlite") {
    self.table = table
    
  }
  
  func create() {
    var stmt = """
      create table if not exists item
         (id integer primary key autoincrement,
          msg text,
          row int,
          timeStamp DateTime );
    """
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = """
    CREATE TRIGGER if NOT EXISTS insert_item_timeStamp AFTER  INSERT ON item
    BEGIN
    UPDATE item SET timeStamp = DATETIME('NOW')  WHERE rowid = new.rowid;
    END;
    """
    
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = """
    CREATE TRIGGER if NOT EXISTS update_item_timeStamp AFTER  UPDATE ON item
    BEGIN
    UPDATE item SET timeStamp = DATETIME('NOW')  WHERE rowid = new.rowid;
    END;
    """
    
    sb.sqlExe(table: table, stmt: stmt)
    
    createLogging()
  }
  
  
  private func createLogging(){
    var stmt = """
      create table if not exists log
         (id integer primary key autoincrement,
          log text,
          row int,
          timeStamp DateTime );
    """
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = """
    CREATE TRIGGER if NOT EXISTS insert_log_timeStamp AFTER  INSERT ON log
    BEGIN
    UPDATE log SET timeStamp = DATETIME('NOW')  WHERE rowid = new.rowid;
    END;
    """
    
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = """
    CREATE TRIGGER if NOT EXISTS update_log_timeStamp AFTER  UPDATE ON log
    BEGIN
    UPDATE log SET timeStamp = DATETIME('NOW')  WHERE rowid = new.rowid;
    END;
    """
    
    sb.sqlExe(table: table, stmt: stmt)
    
    
    stmt = """
    CREATE TRIGGER if NOT EXISTS insert_logItem_timeStamp AFTER  INSERT ON item
    BEGIN
    insert into log (log) select 'insert: '||msg||', '||new.rowid from item;
    END;
    """
    
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = """
    CREATE TRIGGER if NOT EXISTS update_logItem_timeStamp AFTER  UPDATE ON item
    BEGIN
    insert into log (log) select 'update: '||msg||', '||new.rowid from item;
    END;
    """
    
    sb.sqlExe(table: table, stmt: stmt)
  }
  
  
  func insert(msg: String, row: Int){
    let stmt = "insert into item (msg,row) values ('\(msg)',\(row))"
    sb.sqlExe(table: table, stmt: stmt)
  }
  
  func insert(msg: String){
    let stmt = """
    insert into item (msg,row)  select '\(msg)',max(row)+1 from item;
    """
    sb.sqlExe(table: table, stmt: stmt)
    
  }
  
  func log(_ log: String){
    let stmt = """
    insert into log (log,row)  values ('\(log)',1);
    """
    sb.sqlExe(table: table, stmt: stmt)
    
  }
  
  func delete(row: Int){
    let stmt = "delete from item where row=\(row)"
    sb.sqlExe(table: table, stmt: stmt)
    self.populate()
  }
  
  func deleteAll(){
    let stmt = "delete from item"
    sb.sqlExe(table: table, stmt: stmt)
    self.populate()
  }
  
  func drop(){
    var stmt = "drop table if EXISTS item;"
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = "drop table if EXISTS log;"
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = "drop trigger if EXISTS insert_item_timeStamp;"
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = "drop trigger if EXISTS update_item_timeStamp;"
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = "drop trigger if EXISTS insert_log_timeStamp;"
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = "drop trigger if EXISTS  insert_logItem_timeStamp;"
    sb.sqlExe(table: table, stmt: stmt)
    
    stmt = "drop trigger if EXISTS update_logItem_timeStamp;"
    sb.sqlExe(table: table, stmt: stmt)
    
  }
  
  func delIndex(row: Int){
    if row >= db.count + 1 {
      return
    }
    delete(row: db[row].row)
  }
  
  func populate(){
    let stmt = """
      select id, row, msg, timeStamp from item order by row
    """
    db = sb.sqlQuery(table: table, stmt: stmt)
    
  }
  
  func getLogs(){
    let stmt = """
      select id, row, log, timeStamp from log order by timeStamp desc
    """
    dblog = sb.sqlQuery(table: table, stmt: stmt)
    
  }
  
  
  func update(id: Int, msg: String, row: Int) {
    
    print("id: \(id), row: \(row), msg: \(msg)")
    
    let stmt = """
    update item
    set msg = '\(msg)',row = \(row) where
    id=\(id);
    
    """
    sb.sqlExe(table: table, stmt: stmt)
    self.populate()
    
  }
  
  
  
  func swap(from: Int,to: Int){
    if from == to {
      return
    }
    
    let stmt = """
    update item
    set row = (case when row = \(from) then \(to) else \(from) end)
    where row in (\(from), \(to));
    """
    sb.sqlExe(table: table, stmt: stmt)
    self.populate()
  }
  
  func count() -> Int {
    self.populate()
    return db.count
  }
  
  
  
  
}
