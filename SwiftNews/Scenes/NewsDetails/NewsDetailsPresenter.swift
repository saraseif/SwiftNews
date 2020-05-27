//
//  NewsDetailsPresenter.swift
//  SwiftNews
//
//  Created by Sara on 5/26/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit

protocol NewsDetailsPresentationLogic {
    func presentLoadScene(response: NewsDetailsModels.LoadScene.Response)
}

class NewsDetailsPresenter: NewsDetailsPresentationLogic {
    weak var viewController: NewsDetailsDisplayLogic?

    func presentLoadScene(response: NewsDetailsModels.LoadScene.Response) {
        if let newsData = response.newsDetailsData {
            viewController?.displayLoadScene(viewModel: NewsDetailsModels.LoadScene.NewsViewModel(pageTitle: "News Details", title: newsData.title, imageURL: newsData.thumbnailURL, description: newsData.description))
        }
    }
    

}
