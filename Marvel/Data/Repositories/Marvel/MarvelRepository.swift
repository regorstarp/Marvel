//
//  MarvelRepository.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import RxSwift
import Moya

protocol MarvelRepository {
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

class MarvelDataRepository: MarvelRepository {
    private let genericProvider: GenericApiProvider
    private let marvelFactory: MarvelFactory
    
    init(marvelfactory: MarvelFactory,
         genericProvider: GenericApiProvider) {
        self.genericProvider = genericProvider
        self.marvelFactory = marvelfactory
    }
    
    func getComics(with searchText: String?,
                   limit: Int?,
                   offset: Int?) -> Single<ComicsList?> {
        let request = ComicRequest(searchText: searchText,
                                   limit: limit,
                                   offset: offset)
        
        return genericProvider.request(MarvelTarget.getComics(request: request))
            .filterSuccessfulStatusCodes()
            .map(ComicResponse.self)
            .flatMap({ [weak self] response in
                let comics = self?.marvelFactory.createComicList(from: response)
                return Single.just(comics)
            })
    }
}
