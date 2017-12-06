//
//  RepoViewerTests.swift
//  RepoViewerTests
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import RepoViewer

class RepoViewerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepoDTO() {
        guard let data = loadJson(withName: "RepoDTO") else {
            XCTFail("Failed to load json file")
            return
        }
        guard let repo = try? JSONDecoder().decode(RepoDTO.self, from: data) else {
            XCTFail("Failed to decode JSON")
            return
        }
        
        XCTAssertEqual(repo.name, "Hello-World")
        XCTAssertEqual(repo.ownerLogin, "octocat")
        XCTAssertEqual(repo.description, "This your first repo!")
        XCTAssertEqual(repo.fork, true)
    }
}

extension RepoViewerTests {
    func loadJson(withName name: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            return nil
        }
    }
}
