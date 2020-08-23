//
//  DecodingJSONTests.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 23/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import XCTest
@testable import Marvel

class DecodingJSONTests: XCTestCase {
    /// Decodes a type from a bundle filename.
    func decode<T: Decodable>(_ type: T.Type,
                              from filename: String) throws -> T {
        guard let json = Bundle(for: DecodingJSONTests.self).url(forResource: filename,
                                                                 withExtension: nil) else {
            throw ErrorMock.badPath
        }

        let jsonData = try Data(contentsOf: json)

        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self,
                                        from: jsonData)
        return result
    }
    
    func testDecodeComicResponse() throws {
        do {
            let response = try decode(ComicResponse.self,
                                      from: "ComicsList.json")
            
            let firstResult = response.data?.results?.first
            
            XCTAssertEqual(response.data?.total, 117)
            XCTAssertEqual(firstResult?.id, 88627)
            //Prices
            XCTAssertEqual(firstResult?.prices?.first?.type, "printPrice")
            XCTAssertEqual(firstResult?.prices?.first?.price, 3.99)
            //Characters
            XCTAssertEqual(firstResult?.characters?.items?.first?.name, "Avengers")
            XCTAssertEqual(firstResult?.characters?.items?.last?.name, "Ka-Zar")
            //Creators
            XCTAssertEqual(firstResult?.creators?.items?.first?.name, "Tom Brevoort")
            XCTAssertEqual(firstResult?.creators?.items?.first?.role, "editor")
            XCTAssertEqual(firstResult?.creators?.items?.last?.name, "Vc Joe Caramagna")
            XCTAssertEqual(firstResult?.creators?.items?.last?.role, "letterer")
            //Thumbnail
            XCTAssertEqual(firstResult?.thumbnail?.path, "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5f3d36c292e61")
            XCTAssertEqual(firstResult?.thumbnail?.thumbnailExtension, "jpg")
        } catch {
            XCTFail("Failed to decode ComicsList.json with error: \(error)")
        }
    }

    func testDecodePriceResponse() throws {
        do {
            let response = try decode([PriceResponse].self,
                                       from: "Prices.json")
            XCTAssertEqual(response.first?.type, "printPrice")
            XCTAssertEqual(response.first?.price, 3.99)
        } catch {
            XCTFail("Failed to decode Prices.json with error: \(error)")
        }
    }
    
    func testDecodeCharactersResponse() throws {
        do {
            let response = try decode(CharactersResponse.self,
                                       from: "Characters.json")
            XCTAssertEqual(response.items?.first?.name, "Avengers")
            XCTAssertEqual(response.items?.last?.name, "Ka-Zar")
        } catch {
            XCTFail("Failed to decode Characters.json with error: \(error)")
        }
    }
    
    func testDecodeCreatorsResponse() throws {
        do {
            let response = try decode(CreatorsResponse.self,
                                       from: "Creators.json")
            XCTAssertEqual(response.items?.first?.name, "Tom Brevoort")
            XCTAssertEqual(response.items?.first?.role, "editor")
            XCTAssertEqual(response.items?.last?.name, "Vc Joe Caramagna")
            XCTAssertEqual(response.items?.last?.role, "letterer")
        } catch {
            XCTFail("Failed to decode Creators.json with error: \(error)")
        }
    }
    
    func testDecodeComicThumbnailResponse() throws {
        do {
            let response = try decode(ComicThumbnailResponse.self,
                                       from: "Thumbnail.json")
            XCTAssertEqual(response.path, "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5f3d36c292e61")
            XCTAssertEqual(response.thumbnailExtension, "jpg")
        } catch {
            XCTFail("Failed to decode Thumbnail.json with error: \(error)")
        }
    }
}
