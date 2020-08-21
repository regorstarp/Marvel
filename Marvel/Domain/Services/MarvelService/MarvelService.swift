//
//  MarvelService.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import RxSwift

protocol MarvelService {
    /// Fetches a list of comics.
    ///
    /// - Returns: List of comics.
    func getComics() -> Single<[Comic]?>
}

class MarvelServiceImpl: MarvelService {
    private let marvelRepository: MarvelRepository
    
    init(marvelRepository: MarvelRepository) {
        self.marvelRepository = marvelRepository
    }
    
    func getComics() -> Single<[Comic]?> {
        return marvelRepository.getComics()
    }
}