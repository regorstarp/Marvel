//
//  Wireframe.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

public protocol Wireframe {
    func comicDetail(id: Int) -> UIViewController
}

public class WireframeImpl: Wireframe {
    public func comicDetail(id: Int) -> UIViewController {
        return UIViewController()
    }
}
