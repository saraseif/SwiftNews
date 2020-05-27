//
//  NewsDetailsRouter.swift
//  SwiftNews
//
//  Created by Sara on 5/26/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit

@objc protocol NewsDetailsRoutingLogic {
}

protocol NewsDetailsDataPassing {
    var dataStore: NewsDetailsDataStore? { get set }
}

class NewsDetailsRouter: NSObject, NewsDetailsRoutingLogic, NewsDetailsDataPassing {
    
    weak var viewController: NewsDetailsViewController?
    var dataStore: NewsDetailsDataStore?
    
}
