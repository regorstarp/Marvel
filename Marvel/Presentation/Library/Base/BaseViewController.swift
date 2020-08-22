//
//  BaseViewController.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

class BaseViewController<P: BasePresenter>: UIViewController, BaseView {
    // MARK: - Properties
    
    typealias Presenter = P
    var presenter: Presenter!
    private lazy var loadingView = LoadingView(frame: view.frame)
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
        showAlert(title: title, message: message)
    }
    
    //MARK: - Loadable
    
    func showLoading() {
        view.addSubview(loadingView)
    }
    
    func hideLoading() {
        loadingView.removeFromSuperview()
    }
    
    //MARK: - Private methods
    
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
