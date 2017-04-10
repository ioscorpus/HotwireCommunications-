
//  LanguageManager.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 07/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//
//  Singleton that manages the language selection and translations for strings in the app.
import UIKit
class LanguageManager: NSObject {
    static let sharedInstance = LanguageManager()
    var DEFAULTS_KEY_LANGUAGE_CODE:NSString = NSString()
    var availableLocales = [Locale]()
    override init() {
        
        // Manually create a list of available localisations for this example project.
        let english = Locale().initWithLanguageCode(languageCode: "en", name: "English")
        self.availableLocales.append(english as! Locale)
        let spanish = Locale().initWithLanguageCode(languageCode: "es" , name: "Spanish ")
        self.availableLocales.append(spanish as! Locale)
    }
    func setLanguageWithLocale(locale: Locale) {
        UserDefaults.standard.setValue(locale.languageCode, forKey: "DEFAULTS_KEY_LANGUAGE_CODE")
        print("crashing here")
    }
  
  func getSelectedLocale(languageCode:String){
    var selectedValueIndex = 0
    for (index,object) in availableLocales.enumerated(){
      if object.languageCode == languageCode{
         selectedValueIndex = index
        break
      }
    }
    let selectedLocale = availableLocales[selectedValueIndex]
     UserDefaults.standard.setValue(selectedLocale.languageCode, forKey: "DEFAULTS_KEY_LANGUAGE_CODE")
     DEFAULTS_KEY_LANGUAGE_CODE = selectedLocale.languageCode! as NSString
  }
  
  func GetSelectedlanguageFromApplicationSetting(LanguageIndex:Int){
    let selectedLocale = availableLocales[LanguageIndex]
    UserDefaults.standard.setValue(selectedLocale.languageCode, forKey: "DEFAULTS_KEY_LANGUAGE_CODE")
    DEFAULTS_KEY_LANGUAGE_CODE = selectedLocale.languageCode! as NSString
    
  }
  
}
