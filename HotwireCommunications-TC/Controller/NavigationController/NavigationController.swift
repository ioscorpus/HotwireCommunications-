//
//  NavigationController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 02/11/16.
//   Copyright © 2016 Hotwire Communications. All rights reserved.

import UIKit
import Branch

class NavigationController: UINavigationController, BranchDeepLinkingController {
  
    var deepLinkingCompletionDelegate: BranchDeepLinkingControllerCompletionDelegate?
    
    override func viewDidLoad() {
       // super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  func configureControl(withData params: [AnyHashable: Any]!) {
    let mainStoryboard = UIStoryboard(name:kStoryBoardMain, bundle: nil)
    let signUpStoryboard = UIStoryboard(name:kStoryBoardSignUp, bundle: nil)
    let loginValue = params["login"] != nil ? true:false
    let signValue = params["signup"] != nil ? true:false
    let forgotValue = params["forgot"] != nil ? true:false
    
    if loginValue {
      let vc = mainStoryboard.instantiateViewController(withIdentifier: kStoryBoardID_LoginPage)
      self.pushViewController(vc, animated: true)
    }else if signValue {
      let vc = signUpStoryboard.instantiateViewController(withIdentifier: kStoryBoardID_SignUpTermCondition)
      self.pushViewController(vc, animated: true)
    }else if forgotValue {
      let vc = mainStoryboard.instantiateViewController(withIdentifier: kStoryBoardID_ForgotLogin)
      self.pushViewController(vc, animated: true)
    }
    
    }
}
