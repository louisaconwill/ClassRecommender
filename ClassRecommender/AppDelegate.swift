//
//  AppDelegate.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/6/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        GIDSignIn.sharedInstance().clientID = "1024871592920-ao1enqje6e7f3elff6gqr4katbj67hf0.apps.googleusercontent.com"
        Constants.rootRef.unauth()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if Constants.rootRef.authData != nil {
            window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("home")
        } else {
            window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("login")
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            return GIDSignIn.sharedInstance().handleURL(url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    
   


}

