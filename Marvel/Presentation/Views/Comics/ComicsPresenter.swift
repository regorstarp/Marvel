//
//  ComicsPresenter.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import Foundation

protocol ComicsView: BaseView {
    func reload()
}

class ComicsPresenter: BasePresenter {
    // MARK: - Properties
    
    private(set) var comics: [Comic] = []
    
    private var view: ComicsView? {
        return baseView as? ComicsView
    }
    private let marvelService: MarvelService
    
    // MARK: - Initializer
    
    init(marvelService: MarvelService) {
        self.marvelService = marvelService
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        fetchComics()
    }
    
    // MARK: - Private methods
    
    private func fetchComics() {
        view?.showLoading()
        marvelService.getComics()
            .applySchedulers()
            .subscribe(onSuccess: { [weak self] comics in
                self?.view?.hideLoading()
                guard let comics = comics else {
                    self?.view?.showError(title: "There's been a problem",
                                          message: nil)
                    return
                }
                self?.comics = comics
                self?.view?.reload()
            }) { [weak self] error in
                self?.view?.hideLoading()
                self?.view?.showError(title: "There's been a problem",
                                      message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
