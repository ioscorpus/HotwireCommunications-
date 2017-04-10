//
//  BillingInfo.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 10/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import Foundation
public class BillingInfo: NSObject {
  public var header:String?
  var subList:[BillingInfoCell]?
  public var subListIcon:[String]?
  required public init?(sectionHeading:String, withList sectionList:[BillingInfoCell]?, iconList icons:[String]?){
    header = sectionHeading
    subList = sectionList
    subListIcon = icons
  }
}
public class BillingInfoCell {
  public var cellTitle:String?
  public var cellDetailTitleOne:String?
  public var cellDetailTitleTwo:String?
  public var cellIdentifierType:cellIdentifier?
  
  required public init?(title:String?, withSubTextOne detailText1:String?, withSubTextTwo detailText2:String? ,cellIdentifier identifier:cellIdentifier?){
    cellTitle = title
    cellDetailTitleOne = detailText1
    cellDetailTitleTwo = detailText2
    cellIdentifierType = identifier
  }
  required public init?(title:String?, withSubTextOne detailText1:String? ,cellIdentifier identifier:cellIdentifier?){
    cellTitle = title
    cellDetailTitleOne = detailText1
    cellIdentifierType = identifier
  }
  required public init?(title:String?,cellIdentifier identifier:cellIdentifier?){
    cellTitle = title
    cellIdentifierType = identifier
  }
}
