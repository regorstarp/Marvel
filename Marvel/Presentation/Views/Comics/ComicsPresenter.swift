//
//  ComicsPresenter.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

class ComicsPresenter: BasePresenter {
    let marvelService: MarvelService
    
    init(marvelService: MarvelService) {
        self.marvelService = marvelService
    }
}
