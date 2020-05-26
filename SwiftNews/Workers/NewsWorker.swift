//
//  NewsWorker.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation


class NewsWorker {

    public func fetchNews(completion: @escaping (MainInfoData?, Error?) -> Void) {
        
        let queryString = "r/swift/top/.json"
        let apiWorker = APIWorker()
        
        do {
            let _ = try apiWorker.sendGetRequest(to: queryString, params: nil, httpMethod: .Get) { (result: ResponseData?, error) in
                
                completion(result?.mainInfoData, error)
            }
        } catch {
            completion(nil, nil)
        }
    }
}
