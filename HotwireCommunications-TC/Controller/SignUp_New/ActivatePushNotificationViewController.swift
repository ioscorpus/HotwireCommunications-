//
//  ActivatePushNotificationViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 08/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import UserNotifications

class ActivatePushNotificationViewController:BaseViewController {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var lblServiceCreditOffer: UILabel!
  @IBOutlet var lblAboutPushNotificationInfo: UILabel!
  @IBOutlet weak var btnTurnOnPushNotification: UIButton!
  @IBOutlet var notificationImageView: UIImageView!
  // login or signup flag
  var login:Bool = false
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
   
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
   self.navigationController?.navigationBar.isHidden = false
   self.navigationItem.setHidesBackButton(true, animated: false)
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
    NotificationCenter.default.addObserver(self, selector: #selector(ActivatePushNotificationViewController.userAllowPushNotificationSettingToSetNotification(_:)), name: NSNotification.Name(rawValue: "ApplicationDidRegisterForRemoteNotificationsNotification"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(ActivatePushNotificationViewController.userDisallowPushNotificationSettingToSetNotification(_:)), name: NSNotification.Name(rawValue: "ApplicationDidFailToRegisterUserNotificationSettingsNotification"), object: nil)
    updateButtonStatus()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //MARK:- Refresh view
  /***********************************************************************************************************
   <Name> viewUpdateContentOnBasesOfLanguage </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to update content on the bases of language</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    if login{
       self.navigationItem.title =  "AccountSetup".localized(lang: languageCode, comment: "")
    }else{
    self.navigationItem.title =  "SetUp".localized(lang: languageCode, comment: "")
    }
    
    lblPageTitle.text = "TurnOnPushNotification".localized(lang: languageCode, comment: "")
    lblAboutPushNotificationInfo.text = "TurnOnPushNotificationInfoText".localized(lang: languageCode, comment: "")
    lblServiceCreditOffer.text = "FreeServiceCredit".localized(lang: languageCode, comment: "")
    btnTurnOnPushNotification.setTitle("TurnOnPushNotificationBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
  //  btnTurnOnPushNotification.backgroundColor = kColor_ContinuteUnselected
    btnTurnOnPushNotification.isSelected = false
  
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func configureViewProperty(){
      languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Skip".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(ActivatePushNotificationViewController.skipButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setRightBarButton(UIBarButtonItem(customView: btn1), animated: true);
    
  }
  func updateButtonStatus() {
    // as currentNotificationSettings() is set to return an optional, even though it always returns a valid value, we use a sane default (.None) as a fallback
//    let notificationSettings: UIUserNotificationSettings = UIApplication.shared.currentUserNotificationSettings ?? UIUserNotificationSettings(types: UIUserNotificationType.alert, categories: nil)
//  
//    if notificationSettings.types.rawValue == 0 {
//      if UIApplication.shared.isRegisteredForRemoteNotifications {
//        // set button status to 'failed'
//      } else {
//        // set button status to 'default'
//        btnTurnOnPushNotification.backgroundColor =  kColor_continueSelected
//      }
//    } else {
//      // set button status to 'completed'
//        btnTurnOnPushNotification.backgroundColor =  kColor_ContinuteUnselected
//    }
    if UIApplication.shared.isRegisteredForRemoteNotifications {
      // set button status to 'failed'
      btnTurnOnPushNotification.backgroundColor =  kColor_continueUnselected
    } else {
      // set button status to 'default'
      btnTurnOnPushNotification.backgroundColor =  kColor_continueSelected
    }

    
    

  }
  
  //MARK:- IB button action
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>  AnyObject  </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on continue button used to add push notification service </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
   // syntex to open application setting
//    if let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
//      UIApplication.sharedApplication().openURL(settingsURL)
//    }
    //
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
        if !accepted {
          print("Notification access denied.")
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ApplicationDidFailToRegisterUserNotificationSettingsNotification"), object: self)
        }else{
          print("Notification access accepted.")
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ApplicationDidRegisterForRemoteNotificationsNotification"), object: self)
        }
      }
      UIApplication.shared.registerForRemoteNotifications()
    } else {
      // for ios 9 and prior
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
    }
//    if btnTurnOnPushNotification.selected{
//      self.performSegueWithIdentifier(kSegue_PushNotificationActivation, sender: self)
//    }
  }
  /***********************************************************************************************************
   <Name> skipButtonTappedAction </Name>
   <Input Type>  AnyObject  </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on skip button used to navigate to next screen </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func skipButtonTappedAction(_ sender : UIButton){
    if login{
    self.performSegue(withIdentifier: kSegue_AccoutSetup, sender: self)
    }else{
    self.performSegue(withIdentifier: kSegue_VarificationPhoneNo, sender: self)
    }
  }
  
  // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
    self.title = "Back"
    if segue.identifier == kSegue_VarificationPhoneNo{
      if let nextViewController = segue.destination as? VerifyPhoneNoViewController {
        nextViewController.login = login
      }
    }else if segue.identifier == kSegue_AccoutSetup{
      if let nextViewController = segue.destination as? AccountSetupViewController {
        nextViewController.login = login
      }
    }
  }
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>   08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addNotificationObserver(){
    NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(application:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    
  }
  //notification method to update UI
  func applicationWillEnterForeground(application: UIApplication) {
    let languageIndex = UserDefaults.standard.integer(forKey: "language")
    LanguageManager.sharedInstance.GetSelectedlanguageFromApplicationSetting(LanguageIndex: languageIndex)
    print("applicationWillEnterForeground")
    viewUpdateContentOnBasesOfLanguage()
  }
  override func viewDidDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self)
  }


  /***********************************************************************************************************
   <Name> applicationDidRegisterForRemoteNotificationsNotification </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication sucessfully register remote notification </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>   08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func userAllowPushNotificationSettingToSetNotification(_ notification: NSNotification) {
        print("applicationDidRegisterForRemoteNotificationsNotification")
        if login{
          self.performSegue(withIdentifier: kSegue_AccoutSetup, sender: self)
        }else{
          self.performSegue(withIdentifier: kSegue_VarificationPhoneNo, sender: self)
        }
    }
  
//    let notificationSettings: UIUserNotificationSettings = UIApplication.sharedApplication.currentUserNotificationSettings ?? UIUserNotificationSettings(forTypes: [.None], categories: nil)
//    
//    if notificationSettings.types != .none {
//      print("applicationDidRegisterForRemoteNotificationsNotification")
//      if login{
//        self.performSegue(withIdentifier: kSegue_AccoutSetup, sender: self)
//      }else{
//        self.performSegue(withIdentifier: kSegue_VarificationPhoneNo, sender: self)
//      }
//    }
    
//  }
  /***********************************************************************************************************
   <Name> applicationDidFailToRegisterUserNotificationSettingsNotification </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication fail to register remote notification </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>   08/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func userDisallowPushNotificationSettingToSetNotification(_ notification: NSNotification) {
   print("applicationDidFailToRegisterUserNotificationSettingsNotification")
    self.performSegue(withIdentifier: kSegue_VarificationPhoneNo, sender: self)
  }
 }
