//
//  LoginSynacoreViewController.swift
//  HotwireCommunications-TC
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import SynacorCloudId
//import Branch

final class LoginSynacoreViewController: BaseViewController,UIWebViewDelegate{
     let defaultUserDetail = UserDefaults.standard
     var languageCode:String!
  
  @IBOutlet var viewWebLogin: UIView!
  @IBOutlet var viewBaseView: UIView!
   var cloudIdObject:CloudId? {
    didSet {
      guard let cloudId = self.cloudIdObject else {
        return
      }
      self.cloudIdWasSet(cloudId: cloudId)
    }
  }
  var loggedInUser: User?
  private var loggedInProvider: Provider?
  private var hotwireProvider:Provider?
  private var loginWebView:LoginViewController!
  // MARK: values to verify user mailId and phone number
  var userVarification:Bool = false
  var logout:Bool = false
  // MARK:
  @IBOutlet weak var btnSignUp: UIButton!
  @IBOutlet weak var btnForgotLogin: UIButton!
  //MARK:- controller lyfecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(true)
      self.navigationController?.navigationBar.isHidden = true
      self.addNotificationObserver()
       viewUpdate()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.refreshState()
    if self.cloudIdObject != nil {
      return
    }
    CloudId.newInstanceWithConfigAtUrl(Bundle.main.url(forResource: "cloudid-config-hotwirecommunications", withExtension: "json")!) {
      [weak self]
      (cloudId, error) in
      self?.cloudIdObject = cloudId
    }
  }
  
//MARK:- Refresh view
  func viewUpdate(){
      languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
   let localizedExtension = "Language".localized(lang: languageCode, comment: "")
   // self.title =  "SignUp".localized(lang: languageCode, comment: "")
    print(localizedExtension)
  }

//MARK:- ADD notification
  func addNotificationObserver(){
    NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(application:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    
  }
  //notification method to update UI
  func applicationWillEnterForeground(application: UIApplication) {
    let languageIndex = UserDefaults.standard.integer(forKey: "language")
    LanguageManager.sharedInstance.GetSelectedlanguageFromApplicationSetting(LanguageIndex: languageIndex)
    print("applicationWillEnterForeground")
    //viewUpdate()
  }
  override func viewDidDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self)
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  // MARK:- iBoutlet methods
  @IBAction func signUpButtonTappedAction(_ sender: Any) {
    let storyboard = UIStoryboard(name:kStoryBoardSignUp, bundle: nil)
    let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_SignUpTermCondition)
    self.navigationController?.pushViewController(mainViewController, animated: true)
    
  }
  
  @IBAction func forgotLoginButtonTappedAction(_ sender: Any) {
    self.performSegue(withIdentifier: kSegue_ForgotLogin, sender: self)
    
  }
// MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
     HotwireCommunicationApi.sharedInstance.cloudId = self.cloudIdObject
  }
  
  // MARK: Synacore method
  private func cloudIdWasSet(cloudId: CloudId) {
    cloudId.delegate = self
    cloudId.checkKeychainWithCallback {
      (user, provider, error) in
      if self.logout{
       self.loggedInUser = nil
     }else{
        self.loggedInUser = user
      }
      self.refreshState()
    }
    if (cloudId.config.identityProvider != nil)
    {
      guard let loginController = self.cloudIdObject!.loginControllerForConfiguredIdentityProvider() else {
        return
      }
      loginController.delegate = self
      self.addChildViewController(loginController)
      DispatchQueue.main.async {
      self.viewWebLogin.addSubview(loginController.view)
      loginController.didMove(toParentViewController: self)
      loginController.view.frame = self.view.bounds
      }
    }
  }
  
  private func refreshState() {
    if  self.loggedInUser != nil {
      if userVarification{
      let mainStoryboard = "Main"
      loadTabBarControllerPageSelectedByUserOnParticuralIndex(storyBoard: mainStoryboard, withStoryboardIdentifier: "TabBarController", onSelectedIndex: 0)
      return
      }else{
        self.performSegue(withIdentifier: kSegue_UserVarificationtermAndConditon, sender: self)
      }
    }
  }
  func  loadTabBarControllerPageSelectedByUserOnParticuralIndex(storyBoard:String, withStoryboardIdentifier identifier:String, onSelectedIndex index:Int){
    let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
    let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! TabBarViewController
    initialViewController.selectedIndex = index
    appDelegate.window?.rootViewController = initialViewController
    appDelegate.window?.makeKeyAndVisible()
  }
}

extension LoginSynacoreViewController: CloudIdDelegate {
  
  func cloudId(_ cloudId: CloudId, didLogInUser user: User, forProvider provider: Provider) {
    print("cloudId: \(cloudId), didLoginUser: \(user), forProvider: \(provider)")
    logout = false
    loggedInUser = user
    //refreshState()
  }
  
  private func cloudId(cloudId: CloudId, keychainShouldSaveUser user: User, forProvider provider: Provider) -> Bool {
    return true
  }
  
  private func cloudId(cloudId: CloudId, didEncounterError error: NSError) {
    print("error! :\(error)")
  }
}
extension LoginSynacoreViewController: UserDetailsViewControllerDelegate {
  
  func userDetailsViewControllerDidRequestLogout(viewController: AccountViewController) {
    self.loggedInUser = nil
    self.cloudIdObject = HotwireCommunicationApi.sharedInstance.cloudId
    self.cloudIdObject?.clearKeychain()
     logout = true
    //  self.dismissViewControllerAnimated(true, completion: nil)
    //add this block if you want to go back to the login view after the user logs out
//    guard let loginController = self.cloudId!.loginControllerForConfiguredIdentityProvider() else {
//      return
//    }
//    loginController.delegate = self
//    self.presentViewController(loginController, animated: true) {
//    }
  }
}
extension LoginSynacoreViewController: LoginViewControllerDelegate {
  
  func loginViewControllerDidCompleteLogin(_ viewController: LoginViewController) {
//    self.dismissViewControllerAnimated(true, completion: nil)
     viewDidAppear(true)
    }
  
  func loginViewControllerDidPressCancelButton(_ viewController: LoginViewController) {
    self.dismiss(animated: true, completion: nil)
  }
  
  private func loginViewController(viewController: LoginViewController, didEncounterError error: NSError) {
    print(error)
  }
  private func loginViewController(viewController: LoginViewController, webViewProgressDidChange progressPercentage: Float) {
    // var objec = viewController
    
  }
}

final class ProviderTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = "ProviderTableViewCell"
  
  @IBOutlet weak var providerImageView: UIImageView!
  @IBOutlet weak var providerTitleLabel: UILabel!
  @IBOutlet weak var providerTokenLabel: UILabel!
  
}
extension LoginViewController:UIWebViewDelegate{
   public func webViewDidStartLoad(_ webView: UIWebView) {
    print("Start loading")
  }
  
  
}

