//
//  ComicCollectionViewCell.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 20/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit
import Kingfisher

class ComicCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let imageFadeDuration: Double = 0.2
        //Highlighted animation
        static let highlightedAnimationDuration: Double = 0.45
        static let notHighlightedAnimationDuration: Double = 0.4
        static let highlitedAnimationDelay: Double = 0
        static let highlitedAnimationDampingRatio: CGFloat = 1.0
        static let highlightedAnimationInitialVelocity: CGFloat = 0.0
        static let highlightedAnimationTrasnformScale: CGFloat = 0.96
    }
    
    // MARK: - Properties
    
    static let identifier = String(describing: ComicCollectionViewCell.self)
    
    private let imageView = ImageView()
    
    override var isHighlighted: Bool {
        didSet {
            let duration = isHighlighted ? Constants.highlightedAnimationDuration : Constants.notHighlightedAnimationDuration
            let transform = isHighlighted ?
                CGAffineTransform(scaleX: Constants.highlightedAnimationTrasnformScale, y: Constants.highlightedAnimationTrasnformScale) : CGAffineTransform.identity
            let animations = {
                self.transform = transform
            }
            
            UIView.animate(withDuration: duration,
                           delay: Constants.highlitedAnimationDelay,
                           usingSpringWithDamping: Constants.highlitedAnimationDampingRatio,
                           initialSpringVelocity: Constants.highlightedAnimationInitialVelocity,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: animations,
                           completion: nil)
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        autoresizesSubviews = true
        layer.cornerRadius = Constants.cornerRadius
        
        configureImageView()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    // MARK: - Setup
    
    func setup(imageURL: URL?) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL,
                              options: [.transition(.fade(Constants.imageFadeDuration))])
    }
    
    // MARK: - Private methods
    
    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        let constraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
