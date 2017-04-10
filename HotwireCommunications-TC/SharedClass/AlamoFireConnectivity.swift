//
//  AlamoFireConnectivity.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 23/11/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlamoFireConnectivity: NSObject {
  
 class  func alamofireGetRequest(urlString:String, completion: @escaping (_ data: JSON?, _ error: NSError?)->Void){
    print(urlString)
   if  HotwireCommunicationApi.rechability!.isReachable == true {
    
    Alamofire.request(urlString, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
      switch(response.result) {
      case .success(_):
        if let data = response.result.value{
          print(response.result.value!)
           let json = JSON(data)
          completion(json, nil)
        }
      case .failure(_):
        print(response.result.error!)
        completion(nil,response.result.error! as NSError?)
      }
    }
   }else{
    let languageCode:String = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    let userInfo: [NSObject : AnyObject] =
      [
        NSLocalizedDescriptionKey as NSObject : "NoInternet".localized(lang: languageCode, comment: "") as AnyObject,
        NSLocalizedFailureReasonErrorKey as NSObject : "DeviceNotConnected".localized(lang: languageCode, comment: "") as AnyObject
        
    ]
    let rechabilityError:NSError = NSError(domain: "my.domain.error", code: 123, userInfo: userInfo)
    completion(nil, rechabilityError)
    }
  }
  
  /*
class  func alamofirePostRequest(param:[String:AnyObject], withUrlString urlString:String, completion: (_ data: JSON?, _ error: NSError?)->Void){
   print(urlString)
  if  HotwireCommunicationApi.rechability!.isReachable() == true {
    Alamofire.request(.POST, urlString, parameters:param)
    .validate()
    .response { request, response, data, error in
      if data != nil{
      let json = JSON(data: data!)
      print(json)
       completion(data: json, error: nil)
      }else{
        completion(data: nil, error: error)
      }
  }
  }else{
    let languageCode:String = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    let userInfo: [NSObject : AnyObject] =
      [
        NSLocalizedDescriptionKey :  "NoInternet".localized(lang: languageCode, comment: ""),
        NSLocalizedFailureReasonErrorKey : "DeviceNotConnected".localized(lang: languageCode, comment: "")
    ]
    let rechabilityError:NSError = NSError(domain: "my.domain.error", code: 123, userInfo: userInfo)
    completion(data: nil, error: rechabilityError)
    
   }
  }
 */
  
class  func alamofirePostRequest(param:[String:AnyObject], withUrlString urlString:String, completion: @escaping (_ data: JSON?, _ error: NSError?)->Void){
    print(urlString)
    if  HotwireCommunicationApi.rechability?.isReachable == true {
      Alamofire.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON {  response in
        print(response.request as Any)
        print(response.response as Any)
        switch response.result {
        case .success:
          print("Validation Successful")
          if let json = response.result.value {
            print("JSON: \(json)")
            let jsonObject = JSON(json)
            // print(json)
            completion(jsonObject, nil)
          }
        case .failure(let error):
        completion(nil, error as NSError?)
        }
      }
    }else{
      let languageCode:String = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
      let userInfo: [NSObject : AnyObject] =
        [
          NSLocalizedDescriptionKey as NSObject : "NoInternet".localized(lang: languageCode, comment: "") as AnyObject,
          NSLocalizedFailureReasonErrorKey as NSObject : "DeviceNotConnected".localized(lang: languageCode, comment: "") as AnyObject
          
      ]
      let rechabilityError:NSError = NSError(domain: "my.domain.error", code: 123, userInfo: userInfo)
      completion(nil, rechabilityError)
      
    }
  }
  
}
