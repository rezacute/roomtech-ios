//
//  CommandTest.swift
//  houzie
//
//  Created by syahRiza on 2/13/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import XCTest
@testable import houzie

class CommandTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAllCommand() {
        Ev3().dance()
        
        SmartHome().getTemprature()
        
        SmartHome().remote(true)
        
        SmartHome().remote(false)
        
    }


}
