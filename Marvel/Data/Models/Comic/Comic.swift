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

class Creator: Codable {
    let role: String
    let name: String
    
    init(role: String,
         name: String) {
        self.role = role
        self.name = name
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
