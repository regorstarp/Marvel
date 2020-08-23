//
//  ApplicationModule.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        DataModule.setup(defaultContainer)
        ViewModule.setup(defaultContainer)
    }
}
