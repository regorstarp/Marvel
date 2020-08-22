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
    //MARK: - Constants
    
    private enum Constants {
        static let pageSize = 20
    }
    
    // MARK: - Properties
    
    private(set) var comicsList = ComicsList()
    private var view: ComicsView? {
        return baseView as? ComicsView
    }
    private let marvelService: MarvelService
    private var hasMoreComicsAvailableToRequest: Bool = true
    private var isRequestingComics: Bool = false
    var numberOfComics: Int {
        comicsList.comics.count
    }
    var showPaginationLoader: Bool {
        hasMoreComicsAvailableToRequest &&
            !comicsList.comics.isEmpty
    }
    
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
        comicsList = ComicsList()
        fetchComics(with: searchText)
        view?.reload()
    }
    
    func searchBarCancelButtonClicked() {
        comicsList = ComicsList()
        fetchComics()
        view?.reload()
    }
    
    func emptyViewButtonTouchUpInside() {
        fetchComics()
    }
    
    func didSelectComicAt(index: Int) {
        guard let comic = comicsList.comics[safe: index] else {
            return
        }
        wireframe.comicDetail(comic).present(animated: true)
    }
    
    func requestMoreComicsIfNeeded(with searchText: String? = nil) {
        guard hasMoreComicsAvailableToRequest,
            !isRequestingComics else { return }
        fetchComics(with: searchText)
    }
    
    func comic(at index: Int) -> Comic? {
        return comicsList.comics[safe: index]
    }
    
    // MARK: - Private methods
    
    private func showLoading() {
        //Only show the loading when requesting for the first time.
        if comicsList.comics.isEmpty {
            view?.showLoading()
        }
    }
    
    private func hideLoading() {
        //Only show the loading when requesting for the first time.
        if comicsList.comics.isEmpty {
            view?.hideLoading()
        }
    }
    
    private func fetchComics(with searchText: String? = nil) {
        showLoading()
        isRequestingComics = true
        marvelService.getComics(with: searchText,
                                limit: Constants.pageSize,
                                offset: comicsList.comics.count)
            .applySchedulers()
            .subscribe(onSuccess: { [weak self] comicsList in
                guard let self = self else { return }
                
                self.isRequestingComics = false
                self.hideLoading()
                
                guard let comicsList = comicsList else {
                    if self.comicsList.comics.isEmpty { //The initial request failed, show empty state.
                        self.view?.showErrorView(with: "There's been a problem fetching the comic list")
                    } else { //Pagination request, show alert.
                        self.view?.showError(title: "There's been a probem fetching more comics",
                                             message: nil)
                    }
                    return
                }
                
                //Update comicsList.
                self.comicsList.comics.append(contentsOf: comicsList.comics)
                self.comicsList.totalAvailableInServer = comicsList.totalAvailableInServer
                
                //If the server returns the total count of available comics, we check that to find out if there's more comics available to request.
                if self.comicsList.comics.isEmpty {
                    self.hasMoreComicsAvailableToRequest = false
                } else if let totalAvailableFromServer = self.comicsList.totalAvailableInServer {
                    self.hasMoreComicsAvailableToRequest = self.comicsList.comics.count < totalAvailableFromServer
                } else { //If the server doesn't return the total count of available comics, we assume there's more comics to request if we recieve a full page of comics.
                    self.hasMoreComicsAvailableToRequest = comicsList.comics.count == Constants.pageSize
                }
                
                if self.comicsList.comics.isEmpty {
                    self.view?.showNoResultsFound()
                } else {
                    self.view?.reload()
                }
            }) { [weak self] error in
                self?.view?.hideLoading()
                self?.view?.showErrorView(with: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
