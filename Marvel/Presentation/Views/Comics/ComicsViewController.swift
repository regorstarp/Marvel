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
        title = "Comics"
        view.backgroundColor = .orange
        configureCollectionView()
    }
    
    // MARK: - Private methods
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: ComicCollectionViewCell.identifier)
    }
}

extension ComicsViewController: ComicsView {
    func reload() {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier,
                                                            for: indexPath) as? ComicCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        let comic = presenter.comics[indexPath.row]
        cell.setup(imageURL: comic.thumbnailURL)
        return cell
    }
}

extension ComicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  40
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize, height: view.bounds.size.height * 0.6)
    }
}
