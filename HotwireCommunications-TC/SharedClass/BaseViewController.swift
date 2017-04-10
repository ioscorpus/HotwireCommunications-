//
//  BaseViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 09/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

//

import UIKit
// import SynacorCloudId
class BaseViewController: UIViewController {
  enum FlowType {
    case Login
    case SignUp
    case SignUpPopup
    case ResetPassword
    case RecoverUsername
  }
   let swipeInteractionController = SwipeInteractionController()
   let flipPresentAnimationController = FlipPresentAnimationController()
   let flipDismissAnimationController = FlipDismissAnimationController()
  
 func newDoneButtonWithOld(oldButton: UIView, withkeyboadState keyboardShow:Bool) -> UIButton{
  return UIButton()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
       let navigationBar = self.navigationController?.navigationBar
      navigationBar?.isHidden = false
      navigationBar?.isTranslucent = false
      navigationBar?.barStyle = UIBarStyle.default
      navigationBar?.barTintColor = kColor_NavigationBarColor
      navigationBar?.tintColor = UIColor.white
      navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
      UIApplication.shared.isStatusBarHidden = false
      UIApplication.shared.statusBarStyle = .lightContent
     // SFUIDisplay-Semibold
      self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName :kFontStyleSemiBold18!, NSForegroundColorAttributeName : UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  // MARK:- methods to modify navigation bar
  // method to add logo on left
  func setUpLeftImageOnNavigationBar(){
    let image = UIImage(named: "fisionNavbarLogo")
    let imageview:UIImageView = UIImageView.init(frame: kFrame_BarlogoIconSize)
    imageview.image = image
    let logoButton = UIBarButtonItem.init(customView: imageview)
   // ImageButton.tintColor = UIColor.clearColor()
    self.navigationItem.leftBarButtonItem = logoButton
  }
  
  func setUpImageOnNavigationBarCenterTitle(){
    let image = UIImage(named: "fisionNavbarLogo")
    let imageview:UIImageView = UIImageView.init(frame: kFrame_BarlogoIconSize)
    imageview.image = image
   // let logoButton = UIBarButtonItem.init(customView: imageview)
    // ImageButton.tintColor = UIColor.clearColor()
    self.navigationItem.titleView = imageview
  }
  
  
  
  func setUpCancelButonOnRight(){
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Cancel", for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(BaseViewController.cancelButtonTappedAction(_:)
      
      
      ), for: .touchUpInside)
    self.navigationItem.setRightBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
  func setUpCancelButonOnRightWithAnimation(){
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Cancel", for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(BaseViewController.cancelButtonTappedActionWithAnimation), for: .touchUpInside)
    self.navigationItem.setRightBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
  
  //MARK:- IBoutlet Barbutton Action
  func cancelButtonTappedAction(_ sender : AnyObject){
     let languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    let activeSheetTitle:String = "CancelTitle".localized(lang: languageCode, comment: "")
    let activeSheetBody:String = "CancelActiveSheetBody".localized(lang: languageCode, comment: "")
    
    let alert = UIAlertController(title: activeSheetTitle, message: activeSheetBody , preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "ConfirmCancel".localized(lang: languageCode, comment: "Cancel confirm"), style: .default , handler:{ (UIAlertAction)in
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let storyboard = UIStoryboard(name:kStoryBoardMain, bundle: nil)
      let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_LoginPage)
      let nav:UINavigationController = UINavigationController(rootViewController:mainViewController)
      appDelegate.window?.rootViewController = nav
    }))
    alert.addAction(UIAlertAction(title: "Cancel".localized(lang: languageCode, comment: "cancel button"), style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
      print("User click Dismiss button")
    }))
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
  }
  func cancelButtonTappedActionWithAnimation(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyboard = UIStoryboard(name:kStoryBoardMain, bundle: nil)
    let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_LoginPage)
     mainViewController.transitioningDelegate = self
    let nav:UINavigationController = UINavigationController(rootViewController:mainViewController)
    appDelegate.window?.rootViewController = nav
    swipeInteractionController.wireToViewController(viewController: nav)
  }
}
extension UIBarButtonItem {
  class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
    let button = UIButton(type: .custom)
    button.setImage(colorfulImage, for: .normal)
    button.frame = CGRect.init(0, 0, 44.0, 44.0)
    button.addTarget(target, action: action, for: .touchUpInside)
    
    let barButtonItem = UIBarButtonItem(customView: button)
    return barButtonItem
  }
}
extension BaseViewController: UIViewControllerTransitioningDelegate {
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    flipPresentAnimationController.originFrame = self.view.frame
    return flipPresentAnimationController
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    flipDismissAnimationController.destinationFrame =  self.view.frame
    return flipDismissAnimationController
  }
  
  func interactionControllerForDismissal(using animator:UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
  }
}


