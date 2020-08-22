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
    func showNoResultsFound()
    func showErrorView(with message: String)
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
    
    // MARK: - Public methods
    
    func searchBarSearchButtonClicked(with text: String?) {
        guard let searchText = text,
            !searchText.isEmpty else {
            return
        }
        fetchComics(with: searchText)
    }
    
    func searchBarCancelButtonClicked() {
        fetchComics()
    }
    
    func emptyViewButtonTouchUpInside() {
        fetchComics()
    }
    
    func didSelectComicAt(index: Int) {
        guard let comic = comics[safe: index] else {
            return
        }
        wireframe.comicDetail(comic).present(animated: true)
    }
    
    // MARK: - Private methods
    
    private func fetchComics(with searchText: String? = nil) {
        view?.showLoading()
        marvelService.getComics(with: searchText)
            .applySchedulers()
            .subscribe(onSuccess: { [weak self] comics in
                self?.view?.hideLoading()
                guard let comics = comics else {
                    self?.view?.showErrorView(with: "There's been a problem fetching the comic list")
                    return
                }
                self?.comics = comics
                if comics.isEmpty {
                    self?.view?.showNoResultsFound()
                } else {
                    self?.view?.reload()
                }
            }) { [weak self] error in
                self?.view?.hideLoading()
                self?.view?.showErrorView(with: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
