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
    /// - Parameter limit: The optional requested result limit (number of items requeted) of the call.
    /// - Parameter offset: The optional requested offset (number of skipped results) of the call.
    /// - Returns: List of comics.
    func getComics(with searchText: String?,
                   limit: Int?,
                   offset: Int?) -> Single<ComicsList?>
}

class MarvelServiceImpl: MarvelService {
    private let marvelRepository: MarvelRepository
    
    init(marvelRepository: MarvelRepository) {
        self.marvelRepository = marvelRepository
    }
    
    func getComics(with searchText: String?,
                   limit: Int?,
                   offset: Int?) -> Single<ComicsList?> {
        return marvelRepository.getComics(with: searchText,
                                          limit: limit,
                                          offset: offset)
    }
}
