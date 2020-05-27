//
//  NewsDetailsModel.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

// MARK: - ResponseData
struct ResponseData: Codable {
    let kind: String
    let mainInfoData: MainInfoData
    
    enum CodingKeys: String, CodingKey {
        case kind
        case mainInfoData = "data"
    }
}

// MARK: - MainInfoData
struct MainInfoData: Codable {
    let modhash: String?
    let dist: Int?
    let newsListData: [NewsGeneralData]
    
    enum CodingKeys: String, CodingKey {
        case modhash, dist
        case newsListData = "children"
       }
}

// MARK: - ResponseData
struct NewsGeneralData: Codable {
    let kind: String
    let newsData: NewsData
    
    enum CodingKeys: String, CodingKey {
        case kind
        case newsData = "data"
    }
}


// MARK: - NewsData
struct NewsData: Codable {
    let title: String
    let preview: PreviewData?
    let thumbnailURL: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case preview, title
        case thumbnailURL = "thumbnail"
        case description = "selftext"
    }
}

// MARK: - PreviewData
struct PreviewData: Codable {
    let imagesData: [ImagesData]?
    
    private enum CodingKeys: String, CodingKey {
        case imagesData = "images"
    }
}


// MARK: - ImagesData
struct ImagesData: Codable {
    let imageData: ImageData
    
    private enum CodingKeys: String, CodingKey {
        case imageData = "source"
    }
}

// MARK: - ImageData
struct ImageData: Codable {
    let width: Double?
    let height: Double?
    let url: String?
}
