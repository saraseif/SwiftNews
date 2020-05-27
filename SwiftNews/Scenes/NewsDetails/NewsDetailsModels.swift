//
//  NewsDetailsModels.swift
//  SwiftNews
//
//  Created by Sara on 5/26/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

enum NewsDetailsModels {
    
    enum LoadScene {
        struct Request {}
        
        struct Response {
            let newsDetailsData: NewsData?
        }
        
        struct NewsViewModel {
            var pageTitle: String
            let title: String
            let imageURL: String?
            let description: String?
        }
    }
}
