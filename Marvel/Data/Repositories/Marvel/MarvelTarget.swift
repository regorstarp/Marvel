//
//  MarvelTarget.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Moya

enum MarvelTarget {
    static private let publicKey = "659aadca6e5aa712c59235a84be22219"
    static private let privateKey = "bf9a9cbe6e4d3f12ab20decbc108f4ff1ab36459"
    
    case getComics(request: ComicRequest?)
}

// MARK: TargetType Protocol Implementation

extension MarvelTarget: TargetType {
    var baseURL: URL {
        switch self {
        case .getComics:
            return URL(string: "https://gateway.marvel.com/v1/public")!
        }
    }
    
    var path: String {
        switch self {
        case .getComics:
            return "/comics"
        }
    }
    
    var method: Method {
        switch self {
        case .getComics:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getComics:
            return "Example".data(using: .utf8)!
        }
    }
    
    var task: Task {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = (timestamp + MarvelTarget.privateKey + MarvelTarget.publicKey).md5
        var params: [String: Any] = [:]
        params["ts"] = timestamp
        params["apikey"] = MarvelTarget.publicKey
        params["hash"] = hash

        switch self {
        case let .getComics(request):
            params["format"] = "comic"
            params["format"] = "comic"
            params["dateDescriptor"] = "thisMonth"
            params["limit"] = 40
            
            if let request = request {
                params["titleStartsWith"] = request.searchText
            }
            
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getComics:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
