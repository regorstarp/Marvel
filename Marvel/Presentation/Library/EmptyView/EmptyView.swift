//
//  EmptyView.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 21/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

protocol EmptyViewDelegate: AnyObject {
    func buttonTouchUpInside()
}

class EmptyView: UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    private let label = UILabel()
    private let button = UIButton(type: .system)
    
    private weak var delegate: EmptyViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        stackView.addArrangedSubview(label)
        label.numberOfLines = 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with title: String,
               actionTitle: String? = nil,
               delegate: EmptyViewDelegate? = nil) {
        label.text = title
        
        if let actionTitle = actionTitle {
            stackView.addArrangedSubview(button)
            button.setTitle(actionTitle,
                            for: .normal)
            button.addTarget(self,
                             action: #selector(buttonTouchUpInside),
                             for: .touchUpInside)
            self.delegate = delegate
        }
    }
    
    @objc private func buttonTouchUpInside() {
        delegate?.buttonTouchUpInside()
    }
}
