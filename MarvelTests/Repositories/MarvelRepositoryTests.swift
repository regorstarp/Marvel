//
//  MarvelRepositoryTests.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

import XCTest
import Moya
@testable import Marvel

class MarvelRepositoryTests: XCTestCase {
    
    let stubbingProvider = MoyaProvider<MarvelTarget>(stubClosure: MoyaProvider.immediatelyStub)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetComics() throws {
        let expectation = self.expectation(description: "getComics")
        
        
        _ = stubbingProvider.request(.getComic, completion: { (result) in
            switch result {
            case .success(_):
                expectation.fulfill()
            default:
                break
            }
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
