//
//  AlertExtension.swift
// HotwireCommunications
//
// Created by Chetu-macmini-26 on 11/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//  

import Foundation
import UIKit
extension UIViewController{
  func showTheAlertViewWith(title:String, withMessage message:String, languageCode code:String){
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "Ok".localized(lang: code, comment: ""), style: .default, handler: nil)
      alertController.addAction(defaultAction)
      self.present(alertController, animated: true, completion: nil)
  }
  func showTheAlertViewWithLoginButton(title:String, withMessage message:String, languageCode code:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    alertController.addAction(UIAlertAction(title: "LogIn".localized(lang: code, comment: ""), style: .default , handler:{ (UIAlertAction)in
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let storyboard = UIStoryboard(name:kStoryBoardMain, bundle: nil)
      let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_LoginPage)
      let nav:UINavigationController = UINavigationController(rootViewController:mainViewController)
      appDelegate.window?.rootViewController = nav
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
