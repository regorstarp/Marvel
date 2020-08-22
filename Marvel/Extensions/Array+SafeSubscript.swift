//
//  Array+SafeSubscript.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

public extension Array {
    func element(at index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
    
    subscript(safe index: Int) -> Element? {
        return self.element(at: index)
    }
}
