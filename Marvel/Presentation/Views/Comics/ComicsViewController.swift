//
//  ViewController.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 19/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

private enum ComicsViewSection: Int, CaseIterable {
    case comics, loader
}

class ComicsViewController: BaseViewController<ComicsPresenter> {
    // MARK: - Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        title = "Comics"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController?.searchBar.isHidden = true
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.register(ComicCollectionViewCell.self,
                                forCellWithReuseIdentifier: ComicCollectionViewCell.identifier)
        collectionView.register(LoadingCollectionViewCell.self,
                                forCellWithReuseIdentifier: LoadingCollectionViewCell.identifier)
    }
}

extension ComicsViewController: ComicsView {
    func reload() {
        navigationItem.searchController?.searchBar.isHidden = false
        collectionView.backgroundView = nil
        collectionView.reloadData()
    }
    
    func showNoResultsFound() {
        let emptyView = EmptyView(frame: collectionView.frame)
        emptyView.setup(with: "No results found")
        collectionView.backgroundView = emptyView
        collectionView.reloadData()
        
    }
    
    func showErrorView(with message: String) {
        navigationItem.searchController?.searchBar.isHidden = true
        let emptyView = EmptyView(frame: collectionView.frame)
        emptyView.setup(with: "There's been a problem loading the comic list",
                        actionTitle: "Reload",
                        delegate: self)
        collectionView.backgroundView = emptyView
        collectionView.reloadData()
    }
}

extension ComicsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ComicsViewSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let comicsViewSection = ComicsViewSection(rawValue: section) else {
            return .zero
        }
        
        switch comicsViewSection {
        case .comics:
            return presenter.numberOfComics
        case .loader:
            return presenter.showPaginationLoader ? 1 : .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let comicsViewSection = ComicsViewSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch comicsViewSection {
        case .comics:
            guard let comic = presenter.comic(at: indexPath.row),
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier,
                                                              for: indexPath) as? ComicCollectionViewCell else {
                                                                return UICollectionViewCell()
            }
            cell.setup(imageURL: comic.thumbnailURL)
            return cell
            
        case .loader:
            let loaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.identifier, for: indexPath)
            return loaderCell
        }
    }
}

extension ComicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard ComicsViewSection(rawValue: indexPath.section) == .some(.comics) else { return }
        presenter.didSelectComicAt(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10,
                            left: 10,
                            bottom: 10,
                            right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let comicsViewSection = ComicsViewSection(rawValue: indexPath.section) else {
            return .zero
        }
        let padding: CGFloat =  40
        let collectionViewSize = collectionView.bounds.size.width - padding
        
        switch comicsViewSection {
        case .comics:
            
            return CGSize(width: collectionViewSize,
                          height: view.bounds.size.height * 0.6)
        default:
            return CGSize(width: collectionViewSize, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if ComicsViewSection(rawValue: indexPath.section) == .some(.comics),
            indexPath.row == presenter.numberOfComics - 1 {
            presenter.requestMoreComicsIfNeeded(with: navigationItem.searchController?.searchBar.text)
        }
    }
}

extension ComicsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionView.backgroundView = nil
        presenter.searchBarSearchButtonClicked(with: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.backgroundView = nil
        presenter.searchBarCancelButtonClicked()
    }
}

extension ComicsViewController: EmptyViewDelegate {
    func buttonTouchUpInside() {
        collectionView.backgroundView = nil
        presenter.emptyViewButtonTouchUpInside()
    }
}
