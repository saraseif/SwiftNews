//
//  APIWorker.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

class APIWorker {
    
    public enum WebServiceError: Error {
        
        case invalidURL
    }
    
    public enum HttpMethod: String {
        
        case Get = "GET"
        case Post = "POST"
        case Put = "PUT"
        case Delete = "DELETE"
    }
    
    private let baseURL = "https://www.reddit.com"
    
    public func sendGetRequest<T: Codable>(
        
        to queryString: String,
        params: [String:String]?,
        httpMethod: HttpMethod,
        completion: @escaping (T?, Error?) -> Void
        
    ) throws -> URLSessionDataTask? {
        
        let url = URL(string: "\(baseURL)/\(queryString)")!
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            
            throw WebServiceError.invalidURL
        }
        if let params = params {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil, let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData, nil)
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
            
        }
        dataTask.resume()
        return dataTask
    }
}

