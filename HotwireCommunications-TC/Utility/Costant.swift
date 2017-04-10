//
//  Costant.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 09/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import Foundation
import UIKit
// URl for web service
let kBaseUrl = "https://api.hwctesting.com/v1/"

let kValidate_Invitation_Code = "register/invitation_by_code/"
//"register/validate_invitation_code/";
let kValidate_Customer_Number = "register/validate_customer_number/";
let kValidate_Create_user = "register/create_user";
let kValidate_Phone_Number =  "user/contact/validate/phone"; // post
//let kValidate_Phone_Number = "validate/phone/";// get
let kValidate_Email_Number = "user/contact/validate/email" // post
//let kValidate_Email_Number = "validate/email/"; // get
let kVerify_Phone_Number = "user/contact/verify/send/";
let kVerify_Phone_Otp = "user/contact/verify/phone/"
let kVerify_Email_Otp = "user/contact/verify/email/"
//let kTermsOfService = "contract/terms_of_service/"
//let kPrivacyPolicy = "contract/privacy_policy/"
let kPrivacyPolicy = "contract/retrieve/PP/"
let kTermsOfService = "contract/retrieve/TOS/"
// recoverUser
let kRecoverUserNameByPhoneNo = "username_recovery_by_sms"
let kRecoverUserNameByEmail = "username_recovery_by_email"
let kPassword_reset_by_mobile = "password_reset_by_mobile"
let kPassword_reset_by_email = "password_reset_by_email"
let kVerify_email_by_otp = "verify_email_by_otp"
let kVerify_phone_by_otp  = "verify_phone_by_otp"

enum UrlEndPoints:String {
  case Register = "register/"
  case Login = "login/"
}
enum Format:String {
  case xml  = "/format/xml"
  case json  = "/format/json"
  case generic  = "/format/generic"
}
enum ErrorCode:Int {
  case AlreadyUseCredential  = 112
}
// StoryBoard name
let kStoryBoardMain = "Main";
let kStoryBoardSignUp = "SignUp";

// HelpLineNumber
var khelpLineNumber = "(555)5555555";
// tab bar controller color
var kColor_NavigationBarColor = UIColor(red: 50/255, green: 60/255, blue: 68/255, alpha: 1);
var kColor_TabBarSelected = UIColor(red: 238/255, green: 69/255, blue: 86/255, alpha: 1);
var kColor_TabBarBackgroundColor = UIColor(red: 0/255, green: 162/255, blue: 252/255, alpha: 1);
var kColor_LineBorderColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1);
var kColor_HighLightColor = UIColor(red: 39/255, green: 138/255, blue: 255/255, alpha: 1);
var kColor_SignUpbutton = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1);
var kColor_continueSelected = UIColor(red: 22/255, green: 122/255, blue: 255/255, alpha: 1);
var kColor_continueUnselected = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1);
var kColor_ToolBarUnselected = UIColor(red: 221/255, green: 225/255, blue: 231/255, alpha: 1);
var kColor_ContinuteUnselected = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1);
var kColor_LogoutButton = UIColor(red: 69/255, green: 140/255, blue: 255/255, alpha: 1);
//page controllerm screen
var kColor_GreenColor = UIColor(red: 52/255, green: 100/255, blue: 07/255, alpha: 1);
var kColor_Bluecolor = UIColor(red: 16/255, green: 68/255, blue: 120/255, alpha: 1);
var kColor_OrangeColor = UIColor(red: 195/255, green: 70/255, blue: 37/255, alpha: 1);
var kColor_PurpleColor = UIColor(red: 125/255, green: 30/255, blue: 193/255, alpha: 1);
var kColor_YellowColor = UIColor(red: 217/255, green: 142/255, blue: 10/255, alpha: 1);

// DVR Space background color code

var kColor_DVRSpacebackground = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0);

// ViewController Story board ID
let kStoryBoardID_FirsScreen = "firstScreen";
let kStoryBoardID_SignUpSelection = "signUpSelection";
let kStoryBoardID_EmailVarification = "EmailVarification";
let kStoryBoardID_PhoneNoVarification = "PhoneNoVarification";
let kStoryBoardID_ConfirmPhoneNumber = "confirmPhoneNumber";
let kStoryBoardID_PushNotification = "pushNotification";
let kStoryBoardID_SignUpTermCondition = "SignUpTermCondition";
let kStoryBoardID_emailVarification = "LoginEmailVarify"
let kStoryBoardID_LoginPage = "LoginPage";
let kStoryBoardID_ForgotLogin = "ForgotLogin";

// segue identifier
let kSegue_CustomerNumber = "customerNumber";
let kSegue_InstallationCode = "invitationCode";
let kSegue_SignUpNameEntry = "SignUpNameEntry";
let kSegue_LoginScreen = "LoginScreen";

let kSegue_TabBarController = "TabBarController";
let kSegue_TermAndConditon = "termAndConditon";
let kSegue_chooseSignUpMethod = "chooseSignUpMethod";
let kSegue_EnterMobNumber = "EnterMobNumber";
let kSegue_EnterEmailId = "enterEmailID";
let kSegue_EnterPassword = "EnterPassword";
let kSegue_SecurityPin = "SecurityPin";
let kSegue_SecurityQuestion = "SecurityQuestion";
let kSegue_SecurityAns = "securityAns";
let kSegue_WelcomeScreen = "WelcomeScreen";
let kSegue_PushNotificationActivation = "ActivatePushNotification";
let kSegue_VarificationPhoneNo = "VarificationPhoneNo";
let kSegue_VarificationEmailAddress = "VarificationEmailAddress";
let kSegue_UserVarificationtermAndConditon = "TermAndConditon";
let kSegue_AccoutSetup = "AccoutSetup";
let kSegue_SetUpEmail = "SetUpEmail";
let kSegue_VerifyMobileNumber = "verifyMobileNumber";
let kSegue_LoginEmailVarification = "LoginEmailVarification";
let kSegue_ForgotLogin = "ForgotLogin";
let kSegue_RecoveryOption = "RecoveryOption";
let kSegue_ResetEmail = "ResetEmail";

let kSegue_TabBarBaseView = "TabBarBaseView";
// Account Connection
let kSegue_AccountInfoScreen = "AccountInfo"
let kSegue_SignInAndSecurity = "SignInAndSecurity"
let kSegue_BillingInfo = "BillingInfo"
let kSegue_ContactInfo = "ContactInfo"
let kSegue_FamilyMember = "FamilyMember"
let kSegue_Notification = "Notification"
// Account Info
let kSegue_CurrentBalance = "CurrentBalance"
let kSegue_PayBill = "PayBill"
let kSegue_PayDiffrent = "PayDiffrent"

// tableview custom cell identifier
let kCellIdentifier_TermAndCondHeader = "termAndCondHeader";
let kCellIdentifier_TermAndCondRegular = "termAndCondRegular";
let kCellIdentifier_SecurityQues = "SecurityQues";
let kCellIdentifier_SecurityHeader = "SecurityHeader" ;
// forgot login
let kCellIdentifier_ForgotLoginHeader = "ForgotLoginHeader"
let kCellIdentifier_ForgotLoginFooter = "ForgotLoginFooter"

// First Screen Image Array 
let kImageArray = ["WelcomeImage","BillingPayment","Appointments","TVServices","TroubleShooting","PushNotifications"];
let kSecurityQuesList = ["FavoritePlaceToVisit","BestFriendName","FavoriteActor/Actress","MascotFavoriteSportsTeam","MotherMaidenName","NameFirstPet","YourNickname"];
let recoverUsername = ["MobilePhone","Email"];
let resetPassword = ["MobilePhone","Email","CustomerNumber"];
// Static frame size 

let kFrame_BarlogoIconSize = CGRect.init(0, 5, 70, 30);
let KFrame_CancelBarbutton = CGRect.init(0, 0, 75, 30);
let KFrame_Toolbar = CGRect.init(0, 0, 120, 50)
// back button edge
let imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
let titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
// UIFont size
let kFontStyleSemiBold22 = UIFont(name: "SFUIDisplay-Semibold", size: 22);
let kFontStyleSemiBold20 = UIFont(name: "SFUIDisplay-Semibold", size: 20);
let kFontStyleSemiBold18 = UIFont(name: "SFUIDisplay-Semibold", size: 18);
let kFontStyleSemiRegular22 = UIFont(name: "SFUIDisplay-Regular", size: 22);
let kFontStyleSemiRegular20 = UIFont(name: "SFUIDisplay-Regular", size: 20);
let kFontStyleSemiRegular18 = UIFont(name: "SFUIDisplay-Regular", size: 18);
