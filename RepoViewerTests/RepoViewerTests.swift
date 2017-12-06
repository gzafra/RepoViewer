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
    private let expectedDelay: TimeInterval = 5.0 // Expected delay to load images.
    private var repoDTO: RepoDTO? {
        guard let data = loadJson(withName: "RepoDTO") else {
            XCTFail("Failed to load json file")
            return nil
        }
        guard let repo = try? JSONDecoder().decode(RepoDTO.self, from: data) else {
            XCTFail("Failed to decode JSON")
            return nil
        }
        return repo
    }
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepoDTO() {
        guard let repo = repoDTO else { return }
        
        XCTAssertEqual(repo.name, "Hello-World")
        XCTAssertEqual(repo.ownerLogin, "octocat")
        XCTAssertEqual(repo.description, "This your first repo!")
        XCTAssertEqual(repo.fork, true)
    }
    
    func testRepoViewModel() {
        guard let repo = repoDTO else { return }
        let repoViewModel = RepoViewModel(repoDTO: repo)
        
        XCTAssertEqual(repoViewModel.name, repo.name)
        XCTAssertEqual(repoViewModel.description, repo.description)
        XCTAssertEqual(repoViewModel.owner, "@\(repo.ownerLogin)")
        XCTAssertEqual(repoViewModel.backgroundColor, Colors.lightGreen)
    }
    
    func testEndpoints() {
        guard let repoListEndpoint = Endpoint.repoList.url else {
            XCTFail("Failed to load URL")
            return
        }
        XCTAssertEqual(repoListEndpoint, "https://api.github.com/users/xing/repos")
    }
    
    func testRepoAPISuccess() {
        testExpectation(description: "Querying GitHub API", actionBlock: { (expectation) in
            RequestHelper.fetchRepos(with: { result in
                switch result {
                case .success(let data):
                    XCTAssert(data.count > 0)
                case .failure(_ ):
                    XCTFail("Request failed when it should succeed")
                    
                }
                expectation.fulfill()
            })
        }, waitFor: expectedDelay)
    }
    
    func testRepoCell() {
        guard let repo = repoDTO else { return }
        let repoViewModel = RepoViewModel(repoDTO: repo)
        
        let repoCell = RepoCell()
        repoCell.bind(viewModel: repoViewModel)
        
        XCTAssertEqual(repoCell.nameLabel.text, repoViewModel.name)
        XCTAssertEqual(repoCell.ownerLabel.text, repoViewModel.owner)
        XCTAssertEqual(repoCell.descriptionLabel.text, repoViewModel.description)
        XCTAssertEqual(repoCell.backgroundColor, repoViewModel.backgroundColor)
    }
}
