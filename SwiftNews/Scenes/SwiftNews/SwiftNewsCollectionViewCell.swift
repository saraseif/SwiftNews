//
//  SwiftNewsCell.swift
//  SwiftNews
//
//  Created by Sara on 5/24/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
import UIKit

class SwiftNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView?.layer.cornerRadius = 10
        self.containerView?.layer.masksToBounds = true
    }
}
