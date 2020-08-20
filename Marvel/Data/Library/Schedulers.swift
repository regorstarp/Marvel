//
//  Schedulers.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Moya
import RxSwift

enum BackgroundThreadPriority {
    case main
    case high
    case medium
    case low
    
    var schedulerType: SchedulerType {
        switch self {
        case .main:
            return MainScheduler.instance
        case .high:
            return SerialDispatchQueueScheduler(qos: .userInitiated)
        case .medium:
            return SerialDispatchQueueScheduler(qos: .default)
        case .low:
            return SerialDispatchQueueScheduler(qos: .background)
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait {
    func applySchedulers(priority: BackgroundThreadPriority = .low) -> Single<Element> {
        return self.subscribeOn(priority.schedulerType)
            .observeOn(MainScheduler.instance)
    }
    
    func bgThread(priority: BackgroundThreadPriority = .low) -> Single<Element> {
        return self.observeOn(priority.schedulerType)
    }
}
