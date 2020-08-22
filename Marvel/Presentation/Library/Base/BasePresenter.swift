//
//  BasePresenter.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import RxSwift

class BasePresenter {
    // MARK: - Properties
    internal weak var baseView: BaseView?
    internal var disposeBag: DisposeBag
    var wireframe: Wireframe!
    
    // MARK: - Initializers
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    
    // MARK: - Public methods
    
    func attachView<T: BaseView>(view: T) {
        self.baseView = view
    }
}
