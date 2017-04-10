//
//  PayBillViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 12/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class PayBillViewController: BaseViewController {
 
  @IBOutlet var scrollview: UIScrollView!
  @IBOutlet var scrollViewContener: UIView!
 // imageview
  @IBOutlet var pageImageView: UIImageView!
  // header
  @IBOutlet var autoPayHeader: UILabel!
  @IBOutlet var autoPayBlueTextLabel: UILabel!
  // Amount
  @IBOutlet var lblAmount: UILabel!
  @IBOutlet var lblAmountValue: UILabel!
  // pay date
  @IBOutlet var lblPayDate: UILabel!
  @IBOutlet var txtfldPayDate: UITextField!
  @IBOutlet var btnPayDateInfo: UIButton!
  // save card 
  @IBOutlet var lblSaveCard: UILabel!
  @IBOutlet var lblSaveCardValue: UILabel!
  // choose diffrent card
  @IBOutlet var btnDiffrentPaymentMethod: UIButton!
   // submit
  @IBOutlet var btnSubmitPayment: UIButton!
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
    self.title = "Pay Bill"
    // header
    autoPayHeader.text = "You are not Enrolled in Auto Pay"
    autoPayBlueTextLabel.text = "Enroll in Auto Pay Now"
    // amount
    lblAmount.text = "Amount"
    lblAmountValue.text = "$29.38"
    // pay date
    lblPayDate.text = "Pay Date"
    txtfldPayDate.placeholder = "Today"
    // card
    lblSaveCard.text = "Save Card"
    lblSaveCardValue.text = "**** **** ****5432"
    // bottom button
    btnDiffrentPaymentMethod.setTitle("Use Diffrent Payment Method", for: .normal)
    btnSubmitPayment.setTitle("Submit Payment", for: .normal)
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
