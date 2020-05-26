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
    
    func displayNews(viewModel: SwiftNewsModels.NewsFetched.NewsListViewModel)
    func displayError(viewModel: SwiftNewsModels.NewsFetchError.ViewModel)
}

class NewsDetailsViewController: UIViewController {

}

