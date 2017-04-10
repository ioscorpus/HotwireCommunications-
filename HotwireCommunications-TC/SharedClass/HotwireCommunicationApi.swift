//
//  HotwireCommunicationApi.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 18/11/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit
import SynacorCloudId
import ReachabilitySwift

private let HotwireCommunication = HotwireCommunicationApi()
class HotwireCommunicationApi: NSObject {
  class var sharedInstance: HotwireCommunicationApi {
    return HotwireCommunication
  }
  var cloudId: CloudId?
  static var rechability = Reachability.init()
  //  try? Reachability.reachabilityForInternetConnection()
  // create user data object
  var createUserObject :CreateUser?
 
  
}
