//
//  SubtitleTableViewCell.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = String(describing: SubtitleTableViewCell.self)

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.kf.cancelDownloadTask()
        imageView?.image = nil
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
}
