//
//  BasePresenter.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import RxSwift

class BasePresenter {
    internal weak var baseView: BaseView?
    internal var disposeBag: DisposeBag
    var wireframe: Wireframe!
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    
    func attachView<T: BaseView>(view: T) {
        self.baseView = view
    }
}
