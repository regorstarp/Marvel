//
//  MarvelRepositoryTests.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

import XCTest
import RxSwift
import Moya
@testable import Marvel

class MarvelRepositoryTests: XCTestCase {

    var marvelRepositoryMock: MarvelRepositoryMock?
    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        let stubbingProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
        let genericProviderMock = GenericApiProvider(provider: stubbingProvider)
        let marvelFactory = MarvelFactory()
        marvelRepositoryMock = MarvelRepositoryMock(marvelfactory: marvelFactory,
                                                    genericProvider: genericProviderMock)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetComicsSuccessfully() throws {
        let expectation = self.expectation(description: "Fetch books scuccesfully expectation")
        marvelRepositoryMock?.getComicsResultToBeReturned = Single.just(ComicsList())
        marvelRepositoryMock?.getComics(with: nil,
                                    limit: 20,
                                    offset: 0)
            .subscribe(onSuccess: { comicsList in
                if comicsList != nil {
                    expectation.fulfill()
                }
            }, onError: nil).disposed(by: disposeBag)
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetComicsNil() throws {
        let expectation = self.expectation(description: "Fetch books nil expectation")
        marvelRepositoryMock?.getComicsResultToBeReturned = Single.just(nil)
        marvelRepositoryMock?.getComics(with: nil,
                                    limit: 20,
                                    offset: 0)
            .subscribe(onSuccess: { comicsList in
                if comicsList == nil {
                    expectation.fulfill()
                }
            }, onError: nil).disposed(by: disposeBag)
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
