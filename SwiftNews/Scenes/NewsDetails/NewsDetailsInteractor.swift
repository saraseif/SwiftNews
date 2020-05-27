//
//  NewsDetailsInteractor.swift
//  SwiftNews
//
//  Created by Sara on 5/26/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

protocol NewsDetailsBusinessLogic {
    func loadScene()
}
protocol NewsDetailsDataStore {
    var newsDetails: NewsData? { get set }
}


class NewsDetailsInteractor: NewsDetailsBusinessLogic, NewsDetailsDataStore {
    var newsDetails: NewsData? 
    var presenter: NewsDetailsPresentationLogic?
    
    func loadScene() {
        let response = NewsDetailsModels.LoadScene.Response(newsDetailsData: newsDetails)
        presenter?.presentLoadScene(response: response)
    }
}
