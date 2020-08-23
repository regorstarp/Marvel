//
//  Wireframe.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit
import SwinjectStoryboard

protocol Wireframe {
    func comicDetail(_ comic: Comic) -> Screen
}

class WireframeImpl: Wireframe {
    public func comicDetail(_ comic: Comic) -> Screen {
        guard let vc = SwinjectStoryboard.defaultContainer.resolve(ComicDetailViewController.self) else {
            fatalError("Couldn't instantiate ComicDetailViewController")
        }
        vc.presenter.comic = comic
        let navigationController = UINavigationController(rootViewController: vc)
        return Screen(viewController: navigationController)
    }
}
