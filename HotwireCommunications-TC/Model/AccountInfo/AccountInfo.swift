//
//  AccountInfo.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 05/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import Foundation

public class AccountInfo: NSObject {
  public var header:String?
  public var subList:[AccountInfoCell]?
  public var subListIcon:[String]?
  required public init?(sectionHeading:String, withList sectionList:[AccountInfoCell]?, iconList icons:[String]?){
    header = sectionHeading
    subList = sectionList
    subListIcon = icons
  }
}

public class AccountInfoCell {
   public var cellTitle:String?
   public var cellDetailTitle:String?
   public var cellIdentifierType:cellIdentifier?
   required public init?(title:String?, withSubText detailText:String?, cellIdentifier identifier:cellIdentifier?){
    cellTitle = title
    cellDetailTitle = detailText
    cellIdentifierType = identifier
  }
}
