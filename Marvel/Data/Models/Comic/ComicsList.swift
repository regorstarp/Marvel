//
//  ComicsList.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

class ComicsList {
    var comics: [Comic]
    var totalAvailableInServer: Int?
    
    init(comics: [Comic],
         totalAvailableInServer: Int?) {
        self.comics = comics
        self.totalAvailableInServer = totalAvailableInServer
    }
    
    convenience init() {
        self.init(comics: [], totalAvailableInServer: nil)
    }
}
