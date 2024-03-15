//
//  AppDelegate.swift
//  gif
//
//  Created by Duy Tran on 22/08/2022.
//

import UIKit
import DBDebugToolkit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var title = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            if shortcutItem.type == "com.yoursite.yourapp.adduser" {
                title = "123456789"
                
            }
        }        
#if DEBUG
    DBDebugToolkit.setup()
#endif
        return true
    }
    
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if(shortcutItem.type == "com.yoursite.yourapp.adduser" ) {
            self.moveTo(shortcutItem)
        }
        
    }
    
    func moveTo(_ item :UIApplicationShortcutItem) {
        
        if item.type == "com.yoursite.yourapp.adduser" {
           title = "123456789"
            
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

