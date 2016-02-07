//
//  LoginViewController.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/6/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup delegates
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Attempt to sign in silently, this will succeed if
        // the user has recently been authenticated
        GIDSignIn.sharedInstance().signInSilently()
        
    }
    
    
    @IBAction func authenticateWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    // Implement the required GIDSignInDelegate methods
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Auth with Firebase
                Constants.rootRef.authWithOAuthProvider("google", token: user.authentication.accessToken, withCompletionBlock: { (error, authData) in
                    // User is logged in!
                    // Create a new user dictionary accessing the user's info
                    // provided by the authData parameter
                    let newUser = [
                        "provider": authData.provider,
                        "displayName": authData.providerData["displayName"] as? NSString as? String,
                        "firstTime": "1"
                        
                    ]
                    
                    Constants.usersRef.childByAppendingPath(authData.uid).setValue(newUser)
                    
                    self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("home"))!, animated: true, completion: nil)
                    
                })
            } else {
                // Don't assert this error it is commonly returned as nil
                print("\(error.localizedDescription)")
            }
    }
    
    // Implement the required GIDSignInDelegate methods
    // Unauth when disconnected from Google
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            Constants.rootRef.unauth();
    }



}
