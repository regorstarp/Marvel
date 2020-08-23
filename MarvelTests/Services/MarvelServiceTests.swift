//
//  MarvelServiceTests.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 23/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import XCTest
import RxSwift
import Moya
@testable import Marvel

class MarvelServiceTests: XCTestCase {
    
    var marvelServiceMock: MarvelServiceMock?
    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        let stubbingProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
        let genericProviderMock = GenericApiProvider(provider: stubbingProvider)
        let marvelFactory = MarvelFactory()
        let marvelRepositoryMock = MarvelRepositoryMock(marvelfactory: marvelFactory,
                                                    genericProvider: genericProviderMock)
        marvelServiceMock = MarvelServiceMock(marvelRepository: marvelRepositoryMock)
        disposeBag = DisposeBag()
    }

    func testGetComicsSuccessfully() throws {
        let expectation = self.expectation(description: "Fetch books scuccesfully expectation")
        marvelServiceMock?.getComicsResultToBeReturned = Single.just(ComicsList())
        marvelServiceMock?.getComics(with: nil,
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
        marvelServiceMock?.getComicsResultToBeReturned = Single.just(nil)
        marvelServiceMock?.getComics(with: nil,
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
