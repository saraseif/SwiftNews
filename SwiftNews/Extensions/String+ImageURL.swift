//
//  String+ImageURL.swift
//  SwiftNews
//
//  Created by Sara on 5/25/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation
extension String {

    public func isImage() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif"]

        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }

        return false
    }

    public func getExtension() -> String? {
       let ext = (self as NSString).pathExtension

       if ext.isEmpty {
           return nil
       }

       return ext
    }

    public func isURL() -> Bool {
       return URL(string: self) != nil
    }

}
