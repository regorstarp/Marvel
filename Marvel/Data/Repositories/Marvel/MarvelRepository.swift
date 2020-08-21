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
    /// - Returns: List of comics.
    func getComics() -> Single<[Comic]?>
}

class MarvelDataRepository: MarvelRepository {
    private let genericProvider: GenericApiProvider
    private let marvelFactory: MarvelFactory
    
    init(marvelfactory: MarvelFactory,
         genericProvider: GenericApiProvider) {
        self.genericProvider = genericProvider
        self.marvelFactory = marvelfactory
    }

    func getComics() -> Single<[Comic]?> {
        return genericProvider.request(MarvelTarget.getComics)
            .filterSuccessfulStatusCodes()
            .map(ComicResponse.self)
            .flatMap({ [weak self] response in
                let comics = self?.marvelFactory.createComicList(from: response)
                return Single.just(comics)
            })
    }
}
