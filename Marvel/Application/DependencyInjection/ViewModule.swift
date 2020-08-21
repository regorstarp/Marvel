//
//  ViewModule.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation
import Swinject

class ViewModule {
    static func setup(_ defaultContainer: Container) {
        defaultContainer.register(Wireframe.self) { _ in
            WireframeImpl()
        }.inObjectScope(.container)
        resolvePresenters(defaultContainer)
        resolveViewControllers(defaultContainer)
    }
    
    static func resolvePresenters(_ defaultContainer: Container) {
        defaultContainer.register(ComicsPresenter.self) { r in
            ComicsPresenter(marvelService: r.resolve(MarvelService.self)!)
        }
    }
    
    static func resolveViewControllers(_ defaultContainer: Container) {
        func register<P>(vc: BaseViewController<P>.Type) {
            defaultContainer.storyboardInitCompleted(vc) { r, c in
                c.presenter = r.resolve(vc.Presenter.self)!
                c.presenter.wireframe = r.resolve(Wireframe.self)!
            }
        }
        
        register(vc: ComicsViewController.self)
    }
}
