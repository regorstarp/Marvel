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
    
    case getComic
}

// MARK: TargetType Protocol Implementation

extension MarvelTarget: TargetType {
    
    
    var baseURL: URL {
        switch self {
        case .getComic:
            return URL(string: "https://gateway.marvel.com/v1/public")!
        }
    }
    
    var path: String {
        switch self {
        case .getComic:
            return "/comics"
        }
    }
    
    var method: Method {
        switch self {
        case .getComic:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getComic:
            return "Example".data(using: .utf8)!
        }
    }
    
    var task: Task {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = (timestamp + MarvelTarget.privateKey + MarvelTarget.publicKey).md5
        var params: [String:Any] = ["apikey": MarvelTarget.publicKey,
                      "ts": timestamp,
                      "hash": hash]
        
        switch self {
        case .getComic:
            params["limit"] = 40
            return .requestParameters(parameters: params,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getComic:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
