//
//  RepoCell.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import UIKit
import SnapKit

private let cellInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
private let verticalSpacing: CGFloat = 4
private let headerHeight: CGFloat = 25

class RepoCell: UICollectionViewCell {
    static let cellIdentifier = "repoCell"
    
    // MARK: - Outlets
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Repo name"
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "This is a description of the repo"
        label.numberOfLines = 0
        return label
    }()
    let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Owner"
        return label
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
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        
        ownerLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(cellInsets.left)
            make.top.equalTo(contentView.snp.top).offset(cellInsets.top)
            make.height.equalTo(headerHeight)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-cellInsets.right)
            make.top.equalTo(contentView.snp.top).offset(cellInsets.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(cellInsets.left)
            make.trailing.equalTo(contentView.snp.trailing).offset(-cellInsets.right)
            make.top.equalTo(ownerLabel.snp.bottom).offset(verticalSpacing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-cellInsets.bottom)
        }
    }
    
    // MARK: - Public
    
    func bind(viewModel: RepoViewModel) {
        backgroundColor = viewModel.backgroundColor
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.owner
    }
}
