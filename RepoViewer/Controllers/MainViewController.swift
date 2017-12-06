//
//  MainViewController.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Properties
    var isPaging: Bool = false
    var repoList: [RepoViewModel] = []
    var collectionView: UICollectionView!
    var nextPage: Int = 1

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        title = "Repo List"
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 100)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Colors.white
        collectionView.register(RepoCell.self, forCellWithReuseIdentifier: RepoCell.cellIdentifier)
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.cellIdentifier)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
        }
        
        self.collectionView = collectionView
        
        preloadData()
        loadData(withPage: nextPage)
    }
    
    // MARK: - Loading
    func preloadData() {
        // Preload data from cache, if any
        if let cachedData = CacheHelper.get() {
            print("\(cachedData.count) items preloaded from cache")
            self.repoList = cachedData.map({ return RepoViewModel(repoDTO: $0) })
            self.collectionView.reloadData()
        }
    }
    
    func loadData(withPage page: Int) {
        RequestHelper.fetchRepos(with: { result in
            switch result {
            case .success(let data):
                self.isPaging = false
                
                let newData = data.map({ return RepoViewModel(repoDTO: $0) })
                
                // Increase page only if new data has items
                if data.count > 0 {
                    self.nextPage += 1
                }
                
                // Append contents of newData when paging
                if page > 1 {
                    self.repoList.append(contentsOf: newData)
                }else{
                    self.repoList = newData
                }
                
                // Save in cache
                CacheHelper.cache(self.repoList.map({ return $0.repoDTO }))
                
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }, page: page)
    }
    
    // MARK: - UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repoList.count + (isPaging ? 1 : 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < repoList.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoCell.cellIdentifier, for: indexPath) as! RepoCell
            cell.bind(viewModel: repoList[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.cellIdentifier, for: indexPath) as! LoadingCell
            cell.startAnimating()
            return cell
        }
    }
    
}

// MARK: - Paging

extension MainViewController: UIScrollViewDelegate {
    fileprivate static let paginationThreshold: CGFloat = 300
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        
        if !isPaging && (distance < MainViewController.paginationThreshold) {
            isPaging = true
            loadData(withPage: nextPage)
            let lastIndexPath = IndexPath(row: repoList.count, section: 0)
            collectionView.insertItems(at: [lastIndexPath])
        }
    }
}



