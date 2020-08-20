//
//  MarvelFactory.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

class MarvelFactory {
    func createComicList(from response: ComicResponse) -> [Comic]? {
        return response.data?.results?.compactMap({ result -> Comic? in
            guard let id = result.id,
                let name = result.title,
                let description = result.description,
                let thumbnailPath = result.thumbnail?.path,
                let thumbnailExtension = result.thumbnail?.thumbnailExtension,
                let thumbnailURL = URL(string: thumbnailPath + thumbnailExtension) else {
                    return nil
            }
            return Comic(id: id,
                             name: name,
                             description: description,
                             thumbnailURL: thumbnailURL)
        })
    }
}
