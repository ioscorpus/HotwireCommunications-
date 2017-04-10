//
//  HtmlToAttributeString.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 20/12/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import Foundation
import UIKit
  extension Data {
    var attributedString: NSAttributedString? {
      do {
        return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
      } catch let error as NSError {
        print(error.localizedDescription)
      }
      return nil
    }
  }
extension String {
  var utf8Data: Data? {
    return data(using: .utf8)
  }
}
