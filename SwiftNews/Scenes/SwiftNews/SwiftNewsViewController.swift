//
//  SwiftNewsViewController.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol SwiftNewsDisplayLogic: class {
    
    func displayNews(viewModel: SwiftNewsModels.NewsFetched.NewsListViewModel)
    func displayError(viewModel: SwiftNewsModels.NewsFetchError.ViewModel)
}

class SwiftNewsViewController: UICollectionViewController {
    
    var interactor: SwiftNewsBusinessLogic?
    var router: SwiftNewsRouter?
    var viewModel: SwiftNewsModels.NewsFetched.NewsListViewModel?
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width/2
        layout.estimatedItemSize = CGSize(width: width, height: 1)
        return layout
    }()
    
    enum CellIdentifiers: String {
        case collectionViewCell = "SwiftNewsCollectionViewCellIdentifier"
        case collectionViewCellNib = "SwiftNewsCollectionViewCell"
    }

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SwiftNewsInteractor()
        let presenter = SwiftNewsPresenter()
        let router = SwiftNewsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupCollectionView() {

        let nib = UINib(nibName: CellIdentifiers.collectionViewCellNib.rawValue, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: CellIdentifiers.collectionViewCell.rawValue)
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
         }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupCollectionView()
        fetchNewsList()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

// MARK: Display logic

extension SwiftNewsViewController: SwiftNewsDisplayLogic  {
    func displayNews(viewModel: SwiftNewsModels.NewsFetched.NewsListViewModel) {
        self.viewModel = viewModel
                   self.navigationItem.title = viewModel.pageTitle
        
        self.collectionView?.reloadData()
    }
    
    func displayError(viewModel: SwiftNewsModels.NewsFetchError.ViewModel) {
        let alert = UIAlertController(
            
            title: "Error",
            message: viewModel.error,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak self] _ in
            
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Table View delegates

extension SwiftNewsViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.newsList.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return viewModel?.newsList[section]?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.collectionViewCell.rawValue, for: indexPath) as? SwiftNewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let cellItems = viewModel?.newsList[indexPath.section] {
            let newsData = cellItems[indexPath.row]
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.titleLabel.text = newsData.title
            let urlString = newsData.imageURL
            if let url = URL(string: urlString), urlString.isURL(), urlString.isImage() {
                cell.imageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (_) in
                    self.setupCollectionViewCellAfterImageDownloaded()
                })
                cell.imageView.isHidden = false
            } else {
                cell.imageView.isHidden = true
            }
        }
        
        return cell
    }
  
}

// MARK: Private

extension SwiftNewsViewController {
    
    func fetchNewsList() {
        
        let request = SwiftNewsModels.NewsFetched.Request()
        interactor?.fetchSwiftNews(request: request)
    }
    
    func setupCollectionViewCellAfterImageDownloaded() {
        let visibleCells = self.collectionView.indexPathsForVisibleItems
        let visibleSections = IndexSet.init(visibleCells.map { $0.section })
        collectionView.reloadSections(visibleSections)
    }
}
