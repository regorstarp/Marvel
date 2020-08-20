//
//  DataModule.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Swinject

class DataModule {
    static func setup(_ defaultContainer: Container) {
        resolveRepositories(defaultContainer)
        resolveFactories(defaultContainer)
        resolveProviders(defaultContainer)
        resolveServices(defaultContainer)
    }
    
    static func resolveRepositories(_ defaultContainer: Container) {
        defaultContainer.register(MarvelFactory.self) { _ in
            MarvelFactory()
        }
    }
    
    static func resolveFactories(_ defaultContainer: Container) {
        defaultContainer.register(MarvelRepository.self) { r in
            MarvelDataRepository(marvelfactory: r.resolve(MarvelFactory.self)!,
                                 genericProvider: r.resolve(GenericApiProvider.self)!)
        }
    }
    
    static func resolveProviders(_ defaultContainer: Container) {
        defaultContainer.register(GenericApiProvider.self) { _ in
            GenericApiProvider()
        }
    }
    
    static func resolveServices(_ defaultContainer: Container) {
        defaultContainer.register(MarvelService.self) { r in
            MarvelServiceImpl(marvelRepository: r.resolve(MarvelRepository.self)!)
        }
    }
}
