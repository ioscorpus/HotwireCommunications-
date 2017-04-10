//
//  RegisterViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 12/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
  // image view
     @IBOutlet var topImageView: UIImageView!
     @IBOutlet var lblHeaderTitle: UILabel!
  // textfld
     @IBOutlet var txfldUserName: UITextField!
     @IBOutlet var txfldPassword: UITextField!
     @IBOutlet var txfldReTypePassword: UITextField!
     @IBOutlet var txfldCoustomerNo: UITextField!
  // btn
  @IBOutlet var btnContinue: UIButton!
  // sub view
  @IBOutlet var viewCaptch: UIView!
  @IBOutlet var btnCheckCaptch: UIButton!
  
  @IBOutlet var lblNotRobot: UILabel!
  @IBOutlet var imgViewCaptcha: UIImageView!
  
    override func viewDidLoad() {
     super.viewDidLoad()
      printFonts()
      addNotificationObserver()
  
        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewUpdate()
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  //
  func printFonts() {
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames {
      print("------------------------------")
      print("Font Family Name = [\(familyName)]")
      let names = UIFont.fontNames(forFamilyName: familyName)
      print("Font Names = [\(names)]")
    }
  }
  //MARK:- Refresh view
  func viewUpdate(){
    let languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
  //  let localizedExtension = "Language".localized(languageCode)
    // update changes
       viewCaptch.layer.borderColor = kColor_LineBorderColor.cgColor
    lblHeaderTitle.text = "Register_Title".localized(lang: languageCode, comment: "")
    txfldUserName.placeholder = "Username".localized(lang: languageCode, comment: "")
    txfldPassword.placeholder = "Password".localized(lang: languageCode, comment: "")
    txfldReTypePassword.placeholder = "RetypePassword".localized(lang: languageCode, comment: "")
    txfldCoustomerNo.placeholder = "CustomerNumber".localized(lang: languageCode, comment: "")
    btnCheckCaptch.isSelected = false
    lblNotRobot.text = "NotRobot".localized(lang: languageCode, comment: "")
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
    viewUpdate()
  }
  override func viewDidDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self)
  }
   // MARK: - TouchesBegan
  // method to  end editing when user tapped out side
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)->() {
    resignFirstResponder()
    self.view.endEditing(true)
  }
  
  @IBAction func touchUpActionOnView(_ sender: AnyObject) {
    resignFirstResponder()
    self.view.endEditing(true)
  }
  
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
