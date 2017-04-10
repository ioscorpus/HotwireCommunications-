//
//  User.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 29/11/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//
import Foundation
import SwiftyJSON

public class CreateUser {
  public var id : String?
  public var first_name : String?
  public var last_name : String?
  public var phone : Int?
  public var email : String?
  public var default_timezone : Int?
  
//  public var invitation_code : Int?
//  public var customer_number : String?
//  public var password : String?
//  public var pin : Int?
//  public var head_of_household : Int?
//  public var property_name : String?
//  public var property_address_id : String?
//  public var property_object : String?
  
//  "user_id": "189",
//  "first_name": "Jill",
//  "last_name": "Smith",
//  "email": "geoff.baker@hotwirecommunications.com",
//  "phone": "3059889898",
//  "default_timezone": "2"
  
/**
    Constructs the object based on the given dictionary.
    Sample usage:
    let user = User(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: User Instance.
*/
  required public init?(dictionary:[String:JSON]) {
     id = dictionary["user_id"]!.stringValue
//	invitation_code = dictionary["invitation_code"]?.intValue
//	customer_number = dictionary["customer_number"]?.stringValue
		first_name = dictionary["first_name"]!.stringValue
		last_name = dictionary["last_name"]!.stringValue
		phone = dictionary["phone"]!.intValue
		email = dictionary["email"]!.stringValue
    default_timezone = dictionary["default_timezone"]!.intValue
//		password = dictionary["password"]?.stringValue
//		pin = dictionary["pin"]?.intValue
//		head_of_household = dictionary["property_id"]?.intValue
//		property_name = dictionary["property_name"]?.stringValue
//    property_address_id = dictionary["property_address_id"]?.stringValue
//    property_object = dictionary["property_object"]?.stringValue
	}
}
