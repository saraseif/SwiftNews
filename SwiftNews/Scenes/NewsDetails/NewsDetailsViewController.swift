//
//  NewsDetailsViewController.swift
//  SwiftNews
//
//  Created by Sara on 5/24/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit

protocol NewsDetailsDisplayLogic: class {
    
    func displayLoadScene(viewModel: NewsDetailsModels.LoadScene.NewsViewModel)
}

class NewsDetailsViewController: UIViewController, NewsDetailsDisplayLogic {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
    
    var interactor: NewsDetailsBusinessLogic?
    var router: NewsDetailsRouter?
    var viewModel: NewsDetailsModels.LoadScene.NewsViewModel?
    let viewControllerNibName = "NewsDetailsViewController"
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = NewsDetailsInteractor()
        let presenter = NewsDetailsPresenter()
        let router = NewsDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Object lifecycle
    
    required init()
    {
        super.init(nibName: viewControllerNibName, bundle: Bundle.main)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadScene()
    }
    
    // MARK: Display logic
    
    func displayLoadScene(viewModel: NewsDetailsModels.LoadScene.NewsViewModel) {
        self.navigationItem.title = viewModel.pageTitle
        self.titleLable.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        if let urlString = viewModel.imageURL {
            if let url = URL(string: urlString), urlString.isURL(), urlString.isImage() {
                self.imageView?.kf.setImage(with: url)
            } else {
                self.imageViewHeightConstraint.constant = 0
                self.imageView.layoutIfNeeded()
            }
        }
    }
}
