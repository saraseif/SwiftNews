//
//  SwiftNewsInteractor.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

protocol SwiftNewsBusinessLogic {
    
    func fetchSwiftNews(request: SwiftNewsModels.NewsFetched.Request)
    func setNewsDetails(newsDetails: NewsData)
}

protocol SwiftNewsDataStore {
    var newsDetails: NewsData? { get set }
}

class SwiftNewsInteractor: SwiftNewsBusinessLogic, SwiftNewsDataStore {
    var newsDetails: NewsData?
    var presenter: SwiftNewsPresentationLogic?
    var worker: NewsWorker = NewsWorker()

    // MARK: Do something
    
    func fetchSwiftNews(request: SwiftNewsModels.NewsFetched.Request) {
            
        worker.fetchNews(completion: { (mainInfo, error) in
            
            let response = SwiftNewsModels.NewsFetched.Response(newsInfoData: mainInfo, error: error)
            self.presenter?.presentSwiftNews(response: response)
        })
    }
    
    func setNewsDetails(newsDetails: NewsData) {
        self.newsDetails = newsDetails
        presenter?.presentNewsDetailsSelected()
    }
}
