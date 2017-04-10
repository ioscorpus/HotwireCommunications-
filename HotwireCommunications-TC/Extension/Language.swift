//
//  Language.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 07/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//
//

import Foundation

extension String {
    func localized(lang:String,comment: String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle!.localizedString(forKey: self, value: "", table: nil)
        //return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
  func indexOf(string: String) -> String.Index? {
    return range(of:string, options: .literal, range: nil, locale: nil)?.lowerBound
  }

  }
