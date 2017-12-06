//
//  LoadingCell.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    static let cellIdentifier = "loadingCell"
    
    let loadingIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return loader
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
        }
    }

    // MARK: - Public
    
    func startAnimating() {
        loadingIndicator.startAnimating()
    }
    
    func stopAnimating() {
        loadingIndicator.stopAnimating()
    }
}
