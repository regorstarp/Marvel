//
//  MarvelRepositoryMock.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation
import RxSwift
@testable import Marvel

class MarvelRepositoryMock: MarvelRepository {
    var getComicsResultToBeReturned: Single<ComicsList?> = Single.just(ComicsList())
    
    private let genericProvider: GenericApiProvider
    private let marvelFactory: MarvelFactory
    
    init(marvelfactory: MarvelFactory,
         genericProvider: GenericApiProvider) {
        self.genericProvider = genericProvider
        self.marvelFactory = marvelfactory
    }
    
    func getComics(with searchText: String?, limit: Int?, offset: Int?) -> Single<ComicsList?> {
        return getComicsResultToBeReturned
    }
}
