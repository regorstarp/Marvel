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
}

struct ComicResultResponse: Codable {
    let id: Int?
    let thumbnail: ComicThumbnailResponse?
}

struct ComicThumbnailResponse: Codable {
    let path: String?
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
