//
//  YamlKitTests.swift
//  YamlKitTests
//
//  Created by wufan on 2017/5/21.
//  Copyright © 2017年 atoi. All rights reserved.
//

import XCTest
@testable import YamlKit

class YamlKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: "template/basic.yaml"))
            let obj = try YAMLSerialization.yamlObject(with: data)
            
            print("\(obj)")
        } catch {
            print("\(error)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
