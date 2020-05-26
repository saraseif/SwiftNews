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
}

protocol SwiftNewsDataStore {
    
    var newsCode: String? { get set }
}

class SwiftNewsInteractor: SwiftNewsBusinessLogic, SwiftNewsDataStore {

    var presenter: SwiftNewsPresentationLogic?
    var worker: NewsWorker = NewsWorker()
    var newsCode: String? {
        
        didSet {
            
            fetchSwiftNews(request: SwiftNewsModels.NewsFetched.Request())
        }
    }

    // MARK: Do something
    
    func fetchSwiftNews(request: SwiftNewsModels.NewsFetched.Request) {
            
        worker.fetchNews(completion: { (mainInfo, error) in
            
            let response = SwiftNewsModels.NewsFetched.Response(newsListData: mainInfo, error: error)
            self.presenter?.presentSwiftNews(response: response)
        })
    }
}
