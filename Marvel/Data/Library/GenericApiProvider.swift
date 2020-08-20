//
//  GenericApiProvider.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Moya
import RxSwift

class GenericApiProvider {
    
    private var provider: MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget>? = nil) {
        self.provider = provider ?? MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
    func request(_ target: TargetType) -> Single<Response> {
        return provider.rx.request(MultiTarget(target)).bgThread()
    }
}
