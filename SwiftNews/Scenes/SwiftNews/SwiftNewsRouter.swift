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
    func routeToDetailsScene(segue: UIStoryboardSegue?)
}

protocol SwiftNewsDataPassing {
    var dataStore: SwiftNewsDataStore? { get }
}

class SwiftNewsRouter: NSObject, SwiftNewsRoutingLogic, SwiftNewsDataPassing {
    
    weak var viewController: SwiftNewsViewController?
    var dataStore: SwiftNewsDataStore?
    
    // MARK: Routing
    
    func routeToDetailsScene(segue: UIStoryboardSegue?) {
        
        if let _ = segue {
            
            // Do nothing for now, because container view would not be open using Segues for current structure.
            
        } else {
            
            let destinationVC = viewController?.navigationController?.parent as! NewsDetailsViewController
            
        }
    }
}
