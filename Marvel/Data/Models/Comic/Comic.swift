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
    let description: String?
    let creators: [Creator]
    let characters: [String]
    
    init(id: Int,
         thumbnailURL: URL?,
         description: String?,
         creators: [Creator],
         characters: [String]) {
        self.id = id
        self.thumbnailURL = thumbnailURL
        self.description = description
        self.creators = creators
        self.characters = characters
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
