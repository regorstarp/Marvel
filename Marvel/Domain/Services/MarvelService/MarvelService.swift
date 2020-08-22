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
    /// - Parameter searchText: Optional text used to filter comics by title.
    /// - Returns: List of comics.
    func getComics(with searchText: String?) -> Single<[Comic]?>
}

class MarvelServiceImpl: MarvelService {
    private let marvelRepository: MarvelRepository
    
    init(marvelRepository: MarvelRepository) {
        self.marvelRepository = marvelRepository
    }
    
    func getComics(with searchText: String?) -> Single<[Comic]?> {
        return marvelRepository.getComics(with: searchText)
    }
}
