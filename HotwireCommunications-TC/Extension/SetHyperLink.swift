//
//  SetHyperLink.swift
//  HotwireCommunications
//
//  Created by pragya on 27/09/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSLinkAttributeName, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
 }
