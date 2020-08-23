//
//  LoadingCollectionViewCell.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = String(describing: LoadingCollectionViewCell.self)
    private let loadingView = LoadingView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadingView.frame = contentView.bounds
        contentView.addSubview(loadingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingView.prepareForReuse()
    }
}
