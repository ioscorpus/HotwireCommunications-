//
//  PayDiffrentAmountViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 12/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit
import CMPageControl

class PayDifferentAmountViewController: BaseViewController {
  // controller
  @IBOutlet var imgView: UIImageView!
  @IBOutlet var lblHeader: UILabel!
  @IBOutlet var lblDetail: UILabel!
  @IBOutlet var pageController: CMPageControl!
  
  // content step
  @IBOutlet var lblStepOne: UILabel!
   // content
  @IBOutlet var lblMethod: UILabel!
  @IBOutlet var txtFldMethod: UITextField!
  // amount
  @IBOutlet var lblAmount: UILabel!
  @IBOutlet var txtfldAmount: UITextField!
  // date
  @IBOutlet var lblPayDate: UILabel!
  @IBOutlet var txtFldDate: UITextField!
  
  @IBOutlet var btnNext: UIButton!
  
  //data variables
  var languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 12/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
   
    configureViewProperty()
    addNotificationObserver()
    viewUpdateContentOnBasesOfLanguage()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    DispatchQueue.main.async {
      self.configureViewProperty()
    }
  }
  //MARK:- Refresh view
  /***********************************************************************************************************
   <Name> viewUpdateContentOnBasesOfLanguage </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to update content on the bases of language</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 12/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    methodToCreateViewList()
    self.title = "Pay Different Amount"
    lblHeader.text = "Payment Information"
    lblDetail.text = "Enter your payment information"
    lblStepOne.text = "STEP 1 - PAYMENT INFORMATION"
    lblMethod.text = "Method"
    txtFldMethod.placeholder = "Select method"
    lblAmount.text = "Amount"
    txtfldAmount.placeholder = "Required"
    lblPayDate.text = "PayDate"
    txtFldDate.placeholder = "Required"
    btnNext.setTitle("Next", for: .normal)
    
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 12/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func configureViewProperty(){
    
    
  }
  /***********************************************************************************************************
   <Name> methodToCreateViewList </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to create a array list of object which is required to load the account list </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 12/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func methodToCreateViewList(){
    
  }
  
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  12/01/17 </Date>
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
  
}
