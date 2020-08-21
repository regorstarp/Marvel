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
    
    init(id: Int,
         thumbnailURL: URL?) {
        self.id = id
        self.thumbnailURL = thumbnailURL
    }
}
