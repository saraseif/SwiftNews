//
//  SwiftNewsRouter.swift
//  SwiftNews
//
//  Created by Sara on 5/22/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SwiftNewsRoutingLogic {
    func routeToDetailsScene()
}

protocol SwiftNewsDataPassing {
    var dataStore: SwiftNewsDataStore? { get }
}

class SwiftNewsRouter: NSObject, SwiftNewsRoutingLogic, SwiftNewsDataPassing {
    
    weak var viewController: SwiftNewsViewController?
    var dataStore: SwiftNewsDataStore?
    
    // MARK: Routing
    
    func routeToDetailsScene() {
        let newsDetailsViewController = NewsDetailsViewController()
        newsDetailsViewController.router?.dataStore?.newsDetails = dataStore?.newsDetails
        viewController?.navigationController?.pushViewController(newsDetailsViewController, animated: true)
        
    }
}
