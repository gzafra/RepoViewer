//
//  RepoViewerUITests.swift
//  RepoViewerUITests
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import XCTest

class RepoViewerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
