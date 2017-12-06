//
//  TestUtilities.swift
//  RepoViewerTests
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadJson(withName name: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            return nil
        }
    }
    
    func testExpectation(description: String, actionBlock:(XCTestExpectation)->(), waitFor timeout: TimeInterval) {
        let expectation = self.expectation(description: description)
        actionBlock(expectation)
        waitForExpectations(timeout: timeout) { (error) in
            XCTAssertNil(error)
        }
    }
}
