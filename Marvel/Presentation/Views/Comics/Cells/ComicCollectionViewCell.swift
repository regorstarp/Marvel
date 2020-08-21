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
        //BgView
        static let highlightedBgAlpha: CGFloat = 0.2
        static let notHighlightedBgAlpha: CGFloat = 0.1
        static let bgViewGreyScale: CGFloat = 1.0
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
    private let bgView = UIView()
    
    override var isHighlighted: Bool {
        didSet {
            let duration = isHighlighted ? Constants.highlightedAnimationDuration : Constants.notHighlightedAnimationDuration
            let transform = isHighlighted ?
                CGAffineTransform(scaleX: Constants.highlightedAnimationTrasnformScale, y: Constants.highlightedAnimationTrasnformScale) : CGAffineTransform.identity
            let bgAlpha = isHighlighted ? Constants.highlightedBgAlpha : Constants.notHighlightedBgAlpha
            let bgColor = UIColor(white: Constants.bgViewGreyScale,
                                  alpha: bgAlpha)
            let animations = {
                self.transform = transform
                self.bgView.backgroundColor = bgColor
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
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        autoresizesSubviews = true
        layer.cornerRadius = Constants.cornerRadius
        
        configureBackgroundView()
        configureImageView()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func configureBackgroundView() {
        bgView.frame = bounds
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1019638271)
        backgroundView = backgroundView
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
