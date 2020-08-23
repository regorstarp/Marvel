//
//  MarvelFactoryTests.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import XCTest
@testable import Marvel

class MarvelFactoryTests: XCTestCase {
    let marvelFactory = MarvelFactory()
    
    //Mock responses
    let mockPricesResponse = [PriceResponse(type: "printPrice",
                                            price: 3.99)]
    let mockCreatorsResponse = CreatorsResponse(items: [CreatorResponse(role: "writer",
                                                                        name: "Jim Zub")])
    let mockCharactersResponse = CharactersResponse(items: [CharacterResponse(name: "Avengers")])
    let mockThumbnailResponse = ComicThumbnailResponse(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5f3d36c292e61",
                                                       thumbnailExtension: "jpg")
    var mockComicsResultResponse: [ComicResultResponse] = []
    
    //Expected models
    let expectedPrices = [Price(type: "printPrice",
                                price: 3.99)]
    let expectedCreators = [Creator(role: "writer",
                                    name: "Jim Zub")]
    let expectedCharacters = ["Avengers"]
    let expectedThumbnailURLHttp = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5f3d36c292e61.jpg")
    let expectedThumbnailURLHttps = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/6/80/5f3d36c292e61.jpg")
    var expectedComics: [Comic] = []
    
    override func setUpWithError() throws {
        mockComicsResultResponse = [ComicResultResponse(id: 1234,
                                                        thumbnail: mockThumbnailResponse,
                                                        creators: mockCreatorsResponse,
                                                        characters: mockCharactersResponse,
                                                        title: "Title",
                                                        prices: mockPricesResponse)]
        expectedComics = [Comic(id: 1234,
                                thumbnailURL: expectedThumbnailURLHttps,
                                creators: expectedCreators,
                                characters: expectedCharacters,
                                title: "Title",
                                prices: expectedPrices)]
    }
    
    func testCreateComicListSuccessfuly() throws {
        //Mock response
        let mockComicDataResponse = ComicDataResponse(results: mockComicsResultResponse,
                                                      total: 100)
        let mockComicResponse = ComicResponse(data: mockComicDataResponse)
        let factoryComicsList = marvelFactory.createComicList(from: mockComicResponse)
        
        let expectedComicsList = ComicsList(comics: expectedComics,
                                            totalAvailableInServer: 100)
        XCTAssertNotNil(factoryComicsList)
        XCTAssertEqual(expectedComicsList, factoryComicsList)
    }
    
    func testCreateComics() throws {
        let factoryComics = marvelFactory.createComics(from: mockComicsResultResponse)
        XCTAssertNotNil(factoryComics)
        XCTAssertEqual(expectedComics, factoryComics)
    }
    
    func testCreatePrices() throws {
        let factoryPrices = marvelFactory.createPrices(from: mockPricesResponse)
        XCTAssertNotNil(factoryPrices)
        XCTAssertEqual(expectedPrices, factoryPrices)
    }
    
    func testCreateCreators() throws {
        let factoryCreators = marvelFactory.createCreators(from: mockCreatorsResponse)
        XCTAssertNotNil(factoryCreators)
        XCTAssertEqual(expectedCreators, factoryCreators)
    }
    
    func testCreateCharacters() throws {
        let factoryCharacters = marvelFactory.createCharacters(from: mockCharactersResponse)
        XCTAssertNotNil(factoryCharacters)
        XCTAssertEqual(expectedCharacters, factoryCharacters)
    }
    
    func testCreateThumbnail() throws {
        let factoryThumbnailURL = marvelFactory.createThumbnailURL(from: mockThumbnailResponse)
        XCTAssertNotNil(expectedThumbnailURLHttp)
        XCTAssertEqual(expectedThumbnailURLHttp, factoryThumbnailURL)
    }
}
