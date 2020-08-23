//
//  MarvelServiceMock.swift
//  MarvelTests
//
//  Created by Roger Prats Llivina on 23/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
@testable import Marvel

class MarvelServiceMock: MarvelService {
    var getComicsResultToBeReturned: Single<ComicsList?> = Single.just(ComicsList())
    private let marvelRepository: MarvelRepository
    
    init(marvelRepository: MarvelRepository) {
        self.marvelRepository = marvelRepository
    }
    
    func getComics(with searchText: String?, limit: Int?, offset: Int?) -> Single<ComicsList?> {
        return getComicsResultToBeReturned
    }
}
