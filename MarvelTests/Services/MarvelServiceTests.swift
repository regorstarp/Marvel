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
import Swinject
@testable import Marvel

class MarvelServiceTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    func testGetComicsSuccessfully() throws {
        //Dependency injection
        let container = Container()
        container.register(MarvelFactory.self) { _ in
            MarvelFactory()
        }
        container.register(GenericApiProvider.self) { _ in
            let stubbingProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
            return GenericApiProvider(provider: stubbingProvider)
        }
        container.register(MarvelRepository.self) { r in
            MarvelDataRepository(marvelfactory: r.resolve(MarvelFactory.self)!,
                                 genericProvider: r.resolve(GenericApiProvider.self)!)
        }
        container.register(MarvelService.self) { r in
            MarvelServiceImpl(marvelRepository: r.resolve(MarvelRepository.self)!)
        }
        
        guard let marvelService = container.resolve(MarvelService.self) else {
            XCTFail("Failed to resolve MarvelService")
            return
        }
        
        let expectation = self.expectation(description: "Fetch comics success expectation")
        marvelService.getComics(with: nil,
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
        //Dependency injection
        let container = Container()
        container.register(MarvelFactory.self) { _ in
            MarvelFactory()
        }
        let serverErrorEndpointClosure = { (target: MultiTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(500, Data()) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        container.register(GenericApiProvider.self) { _ in
            let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: serverErrorEndpointClosure,
                                                             stubClosure: MoyaProvider.immediatelyStub)
            return GenericApiProvider(provider: stubbingProvider)
        }
        container.register(MarvelRepository.self) { r in
            MarvelDataRepository(marvelfactory: r.resolve(MarvelFactory.self)!,
                                 genericProvider: r.resolve(GenericApiProvider.self)!)
        }
        container.register(MarvelService.self) { r in
            MarvelServiceImpl(marvelRepository: r.resolve(MarvelRepository.self)!)
        }
        
        guard let marvelService = container.resolve(MarvelService.self) else {
            XCTFail("Failed to resolve MarvelService")
            return
        }
        
        let expectation = self.expectation(description: "Fetch comics error expectation")
        marvelService.getComics(with: nil,
                                limit: 20,
                                offset: 0)
            .subscribe(onSuccess: nil, onError: { error in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
