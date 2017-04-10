//  Locate.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 07/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class Locale: NSObject {
    var name:String?
    var languageCode:String?
    func initWithLanguageCode(languageCode: NSString ,name: NSString)->AnyObject{
        self.name = name as String
        self.languageCode = languageCode as String
        return self
    }
 }
