//
//  ComicResponse.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

struct ComicResponse: Codable {
    let data: ComicDataResponse?
}

struct ComicDataResponse: Codable {
    let results: [ComicResultResponse]?
    let total: Int?
}

struct ComicResultResponse: Codable {
    let id: Int?
    let thumbnail: ComicThumbnailResponse?
    let creators: CreatorsResponse?
    let characters: CharactersResponse?
    let title: String?
    let prices: [PriceResponse]?
}

struct ComicThumbnailResponse: Codable {
    let path: String?
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct PriceResponse: Codable {
    let type: String?
    let price: Double?
}

struct CreatorsResponse: Codable {
    let items: [CreatorResponse]?
}

struct CreatorResponse: Codable {
    let role: String?
    let name: String?
}

struct CharactersResponse: Codable {
    let items: [CharacterResponse]?
}

struct CharacterResponse: Codable {
    let name: String?
}
