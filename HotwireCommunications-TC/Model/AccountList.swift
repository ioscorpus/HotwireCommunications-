//
//  AccountList.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 16/11/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import Foundation
class listSection {
  var header:String?
  var subList:[String]?
  var subIconList:[String]?
  var subStringHeaderOne:String?
  var subStringHeaderTwo:String?
  
  
  init(sectionHeading:String, withList sectionList:[String]?, detailText subString:(String,String)?){
   self.header = sectionHeading
    if sectionList != nil{
       self.subList = sectionList
    }else{
      self.subStringHeaderOne = subString?.0
      self.subStringHeaderTwo = subString?.1
    }
  }
  init(sectionHeading:String, withList sectionList:[String]?, iconList icons:[String]?) {
    self.header = sectionHeading
    self.subList = sectionList
    self.subIconList = icons
  }
  
  init(sectionHeading:String,detailText subString:(String,String)?){
    self.header = sectionHeading
      self.subStringHeaderOne = subString?.0
      self.subStringHeaderTwo = subString?.1
  }
  
  
}
