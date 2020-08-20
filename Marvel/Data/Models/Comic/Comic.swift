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
    let name: String
    let description: String
    let thumbnailURL: URL
    
    init(id: Int,
         name: String,
         description: String,
         thumbnailURL: URL) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnailURL = thumbnailURL
    }
}
