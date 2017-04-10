//
//  AppDelegate.swift
//  HotwireCommunications-TC
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import HockeySDK
import UserNotifications
import Branch
import SynacorCloudId

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var applicationObject:UIApplication!
  // synacore
  var loggedInUser: User?
  private var cloudId:CloudId? {
    didSet {
      guard let cloudId = self.cloudId else {
        return
      }
      self.cloudIdWasSet(cloudId: cloudId)
    }
  }
  let mainStoryboard = "Main"
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool{
    // hockey app
    BITHockeyManager.shared().configure(withIdentifier: "f4d05ddd50dc4bceae75a499d8ee7249")
    BITHockeyManager.shared().start()
    BITHockeyManager.shared().authenticator.authenticateInstallation() // This line is obsolete in the crash only builds
    BITHockeyManager.shared().isUpdateManagerDisabled = false
    // IQKeyboard Manger
    // commit testing
    applicationObject = application
    IQKeyboardManager.sharedManager().enable = true
    IQKeyboardManager.sharedManager().enableAutoToolbar = false
    IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
    IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 80.0
    let languageIndex = UserDefaults.standard.integer(forKey: "language")
    LanguageManager.sharedInstance.GetSelectedlanguageFromApplicationSetting(LanguageIndex: languageIndex)
//  code to get language from system class
//     let langageRegion = NSLocale.preferredLanguages().first!
//     let languageDic = NSLocale.componentsFromLocaleIdentifier(langageRegion)
//     let languageIndex = languageDic[NSLocaleLanguageCode]
//     LanguageManager.sharedInstance.getSelectedLocale(languageIndex!)
    let bypassToSignUp:Bool = false
    if bypassToSignUp{
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let storyboard = UIStoryboard(name:kStoryBoardSignUp, bundle: nil)
      let mainViewController = storyboard.instantiateViewController(withIdentifier: "demo")
      let nav:UINavigationController = UINavigationController(rootViewController:mainViewController)
      appDelegate.window?.rootViewController = nav

    }
    let branch = Branch.getTestInstance()
    let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
    // register view controller with key/Users/chetu/Documents/Hotwire Communication Project/Hotwire Source Code iOS/Xcode_Update/mobile-iOS/HotwireCommunications/My Hotwire.entitlements
    branch?.registerDeepLinkController(navigationController, forKey:"~referring_link")
    branch?.initSession(launchOptions: launchOptions, automaticallyDisplayDeepLinkController: true, deepLinkHandler: { params, error in
      if (error == nil) {
        
      } else {
        print("Branch TestBed: Initialization failed\n%@", error!.localizedDescription)
      }
      let notificationName = Notification.Name("BranchCallbackCompleted")
      NotificationCenter.default.post(name: notificationName, object: nil)
    })
    CloudId.newInstanceWithConfigAtUrl(Bundle.main.url(forResource: "cloudid-config-hotwirecommunications", withExtension: "json")!) {
      [weak self]
      (cloudId, error) in
      self?.cloudId = cloudId
      HotwireCommunicationApi.sharedInstance.cloudId = cloudId
    }
    return true
  }
// MARK: - push Notification
  func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
    if notificationSettings.types.rawValue == 0 {
   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ApplicationDidFailToRegisterUserNotificationSettingsNotification"), object: self)
      
    }else{
   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ApplicationDidRegisterForRemoteNotificationsNotification"), object: self)
    }
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("didRegisterForRemoteNotificationsWithDeviceToken")
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().getNotificationSettings(){ (setttings) in
        switch setttings.soundSetting{
        case .enabled:
          
          print("enabled sound setting")
          
        case .disabled:
          
          print("setting has been disabled")
          
        case .notSupported:
          
          print("something vital went wrong here")
        }
      }
    } else {
      // Fallback on earlier versions
    }
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("setting has been disabled")
  }
  
  // Branch Iq delegate methods
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    // pass the url to the handle deep link call
    if (!Branch.getInstance().handleDeepLink(url)) {
      // do other deep link routing for the Facebook SDK, Pinterest SDK, etc
    }
    
    return true
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    
    Branch.getInstance().continue(userActivity)
    
    return true
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification launchOptions: [AnyHashable: Any]) -> Void {
    Branch.getInstance().handlePushNotification(launchOptions)
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

   func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

   func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

   func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    self.saveContext()
  }

  // MARK: - Core Data stack
  lazy var applicationDocumentsDirectory: NSURL = {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.chetu.demotest" in the application's documents Application Support directory.
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count-1] as NSURL
  }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    let modelURL = Bundle.main.url(forResource: "demotest", withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    // Create the coordinator and store
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
    var failureReason = "There was an error creating or loading the application's saved data."
    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    } catch {
      // Report any error we got.
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
      dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
      
      dict[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
      // Replace this with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
      abort()
    }
    
    return coordinator
  }()
  
  lazy var managedObjectContext: NSManagedObjectContext = {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
    let coordinator = self.persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    if managedObjectContext.hasChanges {
      do {
        try managedObjectContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
      }
    }
  }
// syncore
  private func cloudIdWasSet(cloudId: CloudId) {
    cloudId.delegate = self
    cloudId.checkKeychainWithCallback {
      (user, provider, error) in
      self.loggedInUser = user
       self.refreshState()
    }
  }
  private func refreshState() {
    if  self.loggedInUser != nil {

      loadTabBarControllerPageSelectedByUserOnParticuralIndex(storyBoard: mainStoryboard, withStoryboardIdentifier: "TabBarController", onSelectedIndex: 0)
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
extension AppDelegate: CloudIdDelegate {
  
  func cloudId(_ cloudId: CloudId, didLogInUser user: User, forProvider provider: Provider) {
    print("cloudId: \(cloudId), didLoginUser: \(user), forProvider: \(provider)")
    self.loggedInUser = user
  }
  
  func cloudId(_ cloudId: CloudId, keychainShouldSaveUser user: User, forProvider provider: Provider) -> Bool {
    return true
  }
  
  func cloudId(_ cloudId: CloudId, didEncounterError error: NSError) {
    print("error! :\(error)")
  }
}
