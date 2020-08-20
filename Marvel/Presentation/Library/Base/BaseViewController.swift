//
//  BaseViewController.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

class BaseViewController<P: BasePresenter>: UIViewController, BaseView {
    typealias Presenter = P
    var presenter: Presenter!
    var currentLoadable: Loadable?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(view: self)
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    //MARK: - BaseView
    
    func showError(title: String, message: String?) {
        
    }
    
    //MARK: - Loadable
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
