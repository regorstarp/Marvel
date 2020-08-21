//
//  LoadingView.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 21/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .medium
        return activityIndicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        addSubview(activityIndicator)
        activityIndicator.center = center
        activityIndicator.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
