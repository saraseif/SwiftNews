//
//  SwiftNewsPresenter.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit

protocol SwiftNewsPresentationLogic {
    func presentSwiftNews(response: SwiftNewsModels.NewsFetched.Response)
    func presentNewsDetailsSelected()
}

class SwiftNewsPresenter: SwiftNewsPresentationLogic {
    weak var viewController: SwiftNewsDisplayLogic?
    let maxItemsInRow: Int = 4
    typealias NewsDetailsViewModel = SwiftNewsModels.NewsViewModel
    
    func presentSwiftNews(response: SwiftNewsModels.NewsFetched.Response) {
        var newsListViewModel: SwiftNewsModels.NewsFetched.NewsListViewModel
        var newsOrderedDictionary = [Int: [NewsDetailsViewModel]]()
        var newsDetailsDictionary = [Int: [NewsData]]()
        guard response.error == nil, let newsInfoData = response.newsInfoData else {
            
            let viewModel = SwiftNewsModels.NewsFetchError.ViewModel(error: response.error?.localizedDescription ?? "error happened")
            viewController?.displayError(viewModel: viewModel)
            
            return
        }
                
        var sectionNumber: Int = 0
        var sectionList = [NewsDetailsViewModel]()
        var detailsSectionList = [NewsData]()
        let totalNewsCount = newsInfoData.newsListData.count
        for i in 0..<totalNewsCount {
            if totalNewsCount < maxItemsInRow { continue }
            else if i != 0, i%maxItemsInRow == 0 || totalNewsCount - i < maxItemsInRow {
                newsOrderedDictionary[sectionNumber] = sectionList
                newsDetailsDictionary[sectionNumber] = detailsSectionList
                if i%maxItemsInRow == 0 {
                    sectionNumber = sectionNumber+1
                    sectionList = [NewsDetailsViewModel]()
                    detailsSectionList = [NewsData]()
                }
            }
            
            let item = newsInfoData.newsListData[i].newsData
            detailsSectionList.append(item)
            
            let newsVM = SwiftNewsModels.NewsViewModel(title: item.title, imageURL: item.thumbnailURL ?? "", description: item.description)
            sectionList.append(newsVM)
            
            if i == totalNewsCount-1 {
                newsOrderedDictionary[sectionNumber] = sectionList
                newsDetailsDictionary[sectionNumber] = detailsSectionList
            }
        }
        newsListViewModel = SwiftNewsModels.NewsFetched.NewsListViewModel(pageTitle: "Swift Top News", numberOfSections: sectionNumber, newsList: newsOrderedDictionary, newsDetailsViewModel: newsDetailsDictionary)

        DispatchQueue.main.async {
            self.viewController?.displayNews(viewModel: newsListViewModel)
        }
    }
    
    func presentNewsDetailsSelected() {
        DispatchQueue.main.async {
            self.viewController?.routeToNewsDetails()
        }
    }
    
}
