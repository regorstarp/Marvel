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
    
    var disposeBag = DisposeBag()
    
    func testGetComicsSuccessfully() throws {
        let stubbingProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
        let genericProviderMock = GenericApiProvider(provider: stubbingProvider)
        let marvelFactory = MarvelFactory()
        let marvelRepositoryMock = MarvelDataRepository(marvelfactory: marvelFactory,
                                                        genericProvider: genericProviderMock)
        
        
        let expectation = self.expectation(description: "Fetch comics success expectation")
        marvelRepositoryMock.getComics(with: nil,
                                        limit: 20,
                                        offset: 0)
            .subscribe(onSuccess: { comicsList in
                if comicsList != nil {
                    expectation.fulfill()
                }
            }, onError: nil).disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetComicsError() throws {
        let serverErrorEndpointClosure = { (target: MultiTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(500, Data()) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: serverErrorEndpointClosure ,stubClosure: MoyaProvider.immediatelyStub)
        let genericProviderMock = GenericApiProvider(provider: stubbingProvider)
        let marvelFactory = MarvelFactory()
        let marvelRepositoryMock = MarvelDataRepository(marvelfactory: marvelFactory,
                                                        genericProvider: genericProviderMock)
        
        
        let expectation = self.expectation(description: "Fetch comics error expectation")
        marvelRepositoryMock.getComics(with: nil,
                                        limit: 20,
                                        offset: 0)
            .subscribe(onSuccess: nil, onError: { error in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
