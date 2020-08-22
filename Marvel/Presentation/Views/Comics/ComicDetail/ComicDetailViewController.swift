//
//  ComicDetailViewController.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

private enum ComicDetailSections: Int, CaseIterable {
    case header, characters, creators, prices
}

class ComicDetailViewController: BaseViewController<ComicDetailPresenter> {
    // MARK: - Constants
    
    private enum Constants {
        static let imageFadeDuration: Double = 0.2
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemTouchUpInside))
        title = presenter.comic.title
        configureTableView()
    }
    
    // MARK: - Private methods
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: SubtitleTableViewCell.identifier)
    }
    
    @objc private func rightBarButtonItemTouchUpInside() {
        dismiss(animated: true)
    }
}

extension ComicDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        ComicDetailSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comicDetailSection = ComicDetailSections(rawValue: section) else {
            return .zero
        }
        switch comicDetailSection {
        case .header:
            return 1
        case .characters:
            return presenter.comic.characters.count
        case .creators:
            return presenter.comic.creators.count
        case .prices:
            return presenter.comic.prices.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let comicDetailSection = ComicDetailSections(rawValue: section) else {
            return nil
        }
        switch comicDetailSection {
        case .header:
            return nil
        case .characters:
            return "Characters"
        case .creators:
            return "Creators"
        case .prices:
            return "Prices"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let comicDetailSection = ComicDetailSections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch comicDetailSection {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier,
                                                           for: indexPath) as? SubtitleTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.imageView?.kf.indicatorType = .activity
            cell.imageView?.kf.setImage(with: presenter.comic.thumbnailURL,
                                  options: [.transition(.fade(Constants.imageFadeDuration))])
            cell.backgroundColor = .clear
            return cell
            
        case .characters:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier,
                                                           for: indexPath) as? SubtitleTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.textLabel?.text = presenter.comic.characters[safe: indexPath.row]
            return cell
            
        case .creators:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier,
                                                           for: indexPath) as? SubtitleTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.detailTextLabel?.text = presenter.comic.creators[safe: indexPath.row]?.role
            cell.textLabel?.text = presenter.comic.creators[safe: indexPath.row]?.name
            return cell
            
        case .prices:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier,
                                                           for: indexPath) as? SubtitleTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.detailTextLabel?.text = presenter.comic.prices[safe: indexPath.row]?.type
            if let price = presenter.comic.prices[safe: indexPath.row]?.price {
               cell.textLabel?.text = "\(price) €"
            } else {
                cell.textLabel?.text = "Price not available"
            }
            
            
            
            
            return cell
        }
    }
}

extension ComicDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let comicDetailSection = ComicDetailSections(rawValue: indexPath.section) else {
            return UITableView.automaticDimension
        }
        switch comicDetailSection {
        case .header:
            return view.bounds.height * 0.7
        default:
            return UITableView.automaticDimension
        }
        
    }
}
