//
//  GitHubRepositoriesAppTests.swift
//  GitHubRepositoriesAppTests
//
//  Created by Saif Shikdar on 06/12/2023.
//

import XCTest
@testable import GitHubRepositoriesApp

final class GitHubRepositoriesAppTests: XCTestCase {
    
    var viewModel: RepositoryViewModel?
    
    override func setUp() {
        super.setUp()
        
        viewModel = RepositoryViewModel(network: MockNetworkManager())
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchFirstSquareRepositories() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let expectation = self.expectation(description: "Fetch square repository list")
        viewModel?.networkService.fetchRepos(RepositorySquare.self) { result in
            switch result {
                case .success(let repo):
                    // Assert the properties of the movie object you expect to receive
                XCTAssertEqual(repo[0].fullName, "square/yajl-objc")
                XCTAssertEqual(repo[0].description, "Objective-C bindings for YAJL (Yet Another JSON Library) C library")
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
