//
//  ComicRequest.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 21/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

class ComicRequest {
    let searchText: String?
    let limit: Int?
    let offset: Int?
    
    init(searchText: String?,
         limit: Int?,
         offset: Int?) {
        self.searchText = searchText
        self.limit = limit
        self.offset = offset
    }
}
