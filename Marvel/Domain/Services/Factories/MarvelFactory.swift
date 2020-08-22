//
//  MarvelFactory.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

class MarvelFactory {
    // MARK: - Public methods
    
    func createComicList(from response: ComicResponse) -> [Comic]? {
        return response.data?.results?.compactMap({ result -> Comic? in
            guard let id = result.id,
                let thumbnailPath = result.thumbnail?.path,
                let thumbnailExtension = result.thumbnail?.thumbnailExtension,
                let thumbnailURL = URL(string: "\(thumbnailPath).\(thumbnailExtension)"),
                //ignore comics with no image available
                !thumbnailPath.contains("image_not_available"),
                let title = result.title else {
                    return nil
            }
            return Comic(id: id,
                         thumbnailURL: convertURLToHttps(thumbnailURL),
                         creators: createCreators(from: result.creators),
                         characters: createCharacters(from: result.characters),
                         title: title,
                         prices: createPrices(from: result.prices))
        })
    }
    
    // MARK: - Private methods
    
    private func createPrices(from response: [PriceResponse]?) -> [Price] {
        return response?.compactMap({
            guard let type = $0.type,
                let price = $0.price else { return nil }
            return Price(type: type,
                         price: price)
        }) ?? []
    }
    
    private func createCharacters(from response: CharactersResponse?) -> [String] {
        guard let response = response else { return [] }
        return response.items?.compactMap { $0.name } ?? []
    }
    
    private func createCreators(from response: CreatorsResponse?) -> [Creator] {
        guard let response = response else { return [] }
        return response.items?.compactMap({ creatorResponse in
            guard let role = creatorResponse.role,
                let name = creatorResponse.name else { return nil }
            return Creator(role: role,
                           name: name)
        }) ?? []
    }
    
    private func convertURLToHttps(_ url: URL) -> URL? {
        var httpsUrl = URLComponents(string: url.absoluteString)
        httpsUrl?.scheme = "https"
        return httpsUrl?.url
    }
}
