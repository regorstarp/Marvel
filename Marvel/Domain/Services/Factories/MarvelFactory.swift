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
                let thumbnailPath = result.thumbnail?.path,
                let thumbnailExtension = result.thumbnail?.thumbnailExtension,
                let thumbnailURL = URL(string: "\(thumbnailPath).\(thumbnailExtension)"),
                //ignore comics with no image available
                !thumbnailPath.contains("image_not_available") else {
                    return nil
            }
            return Comic(id: id,
                             thumbnailURL: convertURLToHttps(thumbnailURL))
        })
    }
    
    private func convertURLToHttps(_ url: URL) -> URL? {
        var httpsUrl = URLComponents(string: url.absoluteString)
        httpsUrl?.scheme = "https"
        return httpsUrl?.url
    }
}
