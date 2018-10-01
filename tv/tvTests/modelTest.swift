//
//  modelTest.swift
//  tvTests
//
//  Created by Michael Chirico on 9/29/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//


import XCTest
@testable import tv

class modelTests: XCTestCase {
  
  let m = Model(table: "modelTest.sqlite")
  
  
  override func setUp() {
    m.create()
    m.insert(msg: "test", row: 0)
    m.insert(msg: "Hello?", row: 1)
  }
  
  override func tearDown() {
    m.drop()
  }
  
  
  func testSwap() {
    m.populate()
    m.swap(from: 0, to: 1)
    XCTAssert(m.count() == 2)
    XCTAssert(m.db[1].msg == "test")
    
  }
  
  
  func testModel() {
    m.populate()
    XCTAssert(m.count() == 2)
    XCTAssert(m.db[0].msg == "test")
    
    m.delete(row: 1)
    XCTAssert(m.count() == 1)
  }
  
  func testDelIndex() {
    m.populate()
    XCTAssert(m.count() == 2)
    XCTAssert(m.db[0].msg == "test")
    m.delIndex(row: 0)
    XCTAssert(m.count() == 1)
    XCTAssert(m.db[0].msg == "Hello?")
    
  }
  
  func testLog() {
    m.populate()
    XCTAssert(m.count() == 2)
    XCTAssert(m.db[0].msg == "test")
    m.log("This is a test")
    m.getLogs()
    XCTAssert(m.dblog.count == 10)
    
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
