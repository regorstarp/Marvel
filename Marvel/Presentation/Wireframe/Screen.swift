//
//  Screen.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

class Screen {
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func present(animated: Bool,
                 completion: (() -> Void)? = nil) {
        UIApplication.topViewController()?.present(viewController,
                                                   animated: animated,
                                                   completion: completion)
    }
}
