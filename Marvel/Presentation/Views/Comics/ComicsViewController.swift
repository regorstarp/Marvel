//
//  ViewController.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 19/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let comic = presenter.comics[safe: indexPath.row],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier,
                                                            for: indexPath) as? ComicCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        cell.setup(imageURL: comic.thumbnailURL)
        return cell
    }
}

extension ComicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
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
        let padding: CGFloat =  40
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize,
                      height: view.bounds.size.height * 0.6)
    }
}

extension ComicsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
