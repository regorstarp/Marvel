//
//  MarvelTarget.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Keys
import Moya

enum MarvelTarget {
    case getComics(request: ComicRequest)
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
    
    var method: Moya.Method {
        switch self {
        case .getComics:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getComics:
            //We need create a test class that inherits from NSObject to find the Bundle.
            class TestClass: NSObject {}
            guard let json = Bundle(for: TestClass.self).url(forResource: "ComicsList.json", withExtension: nil),
                let data = try? Data(contentsOf: json) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        //Api keys
        let keys = MarvelKeys()
        let publicKey = keys.marvelAPIPublicKey
        let privateKey = keys.marvelAPIPrivateKey
        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = (timestamp + privateKey + publicKey).md5
        var params: [String: Any] = [:]
        params["ts"] = timestamp
        params["apikey"] = publicKey
        params["hash"] = hash
        
        switch self {
        case let .getComics(request):
            params["format"] = "comic"
            params["formatType"] = "comic"
            params["dateDescriptor"] = "thisMonth"
            
            if let searchText = request.searchText,
                !searchText.isEmpty {
                params["titleStartsWith"] = searchText
            }
            
            request.limit.map {
                params["limit"] = $0
            }
            
            request.offset.map {
                params["offset"] = $0
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

