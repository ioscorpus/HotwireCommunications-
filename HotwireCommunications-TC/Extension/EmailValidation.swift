//
//  EmailValidation.swift
// HotwireCommunications
//
// Created by Chetu-macmini-26 on 20/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//


import Foundation
extension BaseViewController{
/***********************************************************************************************************
 <Name> isValidEmail </Name>
 <Input Type>    </Input Type>
 <Return> void </Return>
 <Purpose> Is used to validate email id</Purpose>
 <History>
 <Header> Version 1.0 </Header>
 <Date> 02/06/16 </Date>
 </History>
 ***********************************************************************************************************/
  // email validation method to return boolen
func isValidEmail(testStr:String) -> Bool {
  let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
  return emailTest.evaluate(with: testStr)
}
  func testMsg(){
    print("test")
  }
}
