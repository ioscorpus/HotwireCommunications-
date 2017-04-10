//
//  InvitationCode.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 23/11/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//
import Foundation
import SwiftyJSON

public class InvitationCode {
	public var id : Int?
	public var first_name : String?
	public var last_name : String?
	public var emailaddress : String?
	public var phone : Int?
	public var property_address_id : Int?
	public var property_name : String?
	public var head_household_invite : Int?

  required public init?(invitationCode:[String:JSON]) {
    id = invitationCode["id"]!.intValue
    first_name = invitationCode["first_name"]!.stringValue
    last_name = invitationCode["last_name"]!.stringValue
    emailaddress = invitationCode["emailaddress"]!.stringValue
    phone = invitationCode["phone"]!.intValue
    property_address_id = invitationCode["property_address_id"]!.intValue
    property_name = invitationCode["property_name"]!.stringValue
    head_household_invite = invitationCode["head_household_invite"]!.intValue
  }
  
}
