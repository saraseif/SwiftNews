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
}

class SwiftNewsPresenter: SwiftNewsPresentationLogic {
    weak var viewController: SwiftNewsDisplayLogic?
    let maxItemsInRow: Int = 4
    
    func presentSwiftNews(response: SwiftNewsModels.NewsFetched.Response) {
        var newsListViewModel: SwiftNewsModels.NewsFetched.NewsListViewModel
        var newsOrderedDictionary = [Int: [SwiftNewsModels.NewsFetched.NewsViewModel]]()
        guard response.error == nil, let newsListData = response.newsListData else {
            
            let viewModel = SwiftNewsModels.NewsFetchError.ViewModel(error: response.error?.localizedDescription ?? "error happened")
            viewController?.displayError(viewModel: viewModel)
            
            return
        }
                
        var sectionNumber: Int = 0
        var sectionList = [SwiftNewsModels.NewsFetched.NewsViewModel]()
        let totalNewsCount = newsListData.children.count
        for i in 1...totalNewsCount {
            if totalNewsCount < maxItemsInRow
            {
                continue
            }
            else if i != 1, (i-1)%maxItemsInRow == 0 {//|| i-(SwiftNewsPresenter.maxItemsInRow * sectionNumber) < SwiftNewsPresenter.maxItemsInRow {
                newsOrderedDictionary[sectionNumber] = sectionList
                sectionNumber = sectionNumber+1
                sectionList = [SwiftNewsModels.NewsFetched.NewsViewModel]()
            }
            
            let item = newsListData.children[i-1].newsData
            let newsVM = SwiftNewsModels.NewsFetched.NewsViewModel(title: item.title, imageURL: item.thumbnailURL ?? "")
            sectionList.append(newsVM)
        }
        newsListViewModel = SwiftNewsModels.NewsFetched.NewsListViewModel(pageTitle: "Swift Top News", numberOfSections: sectionNumber, newsList: newsOrderedDictionary)

        DispatchQueue.main.async {
            self.viewController?.displayNews(viewModel: newsListViewModel)
        }
    }
    
}
