//
//  BaseView.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

protocol BaseView: AnyObject, Loadable {
    var currentLoadable: Loadable? { get set }
    func showError(title: String, message: String?)
}

protocol Loadable {
    func showLoading()
    func hideLoading()
}
