//
//  Comic.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

class Comic {
    let id: Int
    let thumbnailURL: URL?
    let creators: [Creator]
    let characters: [String]
    let title: String
    let prices: [Price]
    
    init(id: Int,
         thumbnailURL: URL?,
         creators: [Creator],
         characters: [String],
         title: String,
         prices: [Price]) {
        self.id = id
        self.thumbnailURL = thumbnailURL
        self.creators = creators
        self.characters = characters
        self.title = title
        self.prices = prices
    }
}

extension Comic: Equatable {
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.id == rhs.id &&
        lhs.thumbnailURL == rhs.thumbnailURL &&
            lhs.creators == rhs.creators &&
            lhs.characters == rhs.characters &&
            lhs.title == rhs.title &&
            lhs.prices == rhs.prices
    }
}

class Creator: Codable {
    let role: String
    let name: String
    
    init(role: String,
         name: String) {
        self.role = role
        self.name = name
    }
}

extension Creator: Equatable {
    static func == (lhs: Creator, rhs: Creator) -> Bool {
        return lhs.role == rhs.role &&
            lhs.name == rhs.name
    }
}

class Price: Codable {
    let type: String
    let price: Double
    
    init(type: String,
         price: Double) {
        self.type = type
        self.price = price
    }
}

extension Price: Equatable {
    static func == (lhs: Price, rhs: Price) -> Bool {
        return lhs.price == rhs.price &&
            lhs.type == rhs.type
    }
}
