//
//  SwiftNewsModels.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

// MARK: Use cases
enum SwiftNewsModels {
    
    enum NewsFetched {
        struct Request {}
        
        struct Response {
            var newsInfoData: MainInfoData?
            var error: Error?
        }
        
        struct NewsListViewModel {
            var pageTitle: String
            var numberOfSections: Int?
            var newsList: [Int: [NewsViewModel]]
            var newsDetailsViewModel:  [Int: [NewsData]]
        }
    }
    
    enum NewsFetchError {
        struct ViewModel {
            let error: String
        }
    }
    
    struct NewsViewModel {
        let title: String
        let imageURL: String
        let description: String?
    }
}
