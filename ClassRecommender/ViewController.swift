//
//  ViewController.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/6/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    var ref: Firebase!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Firebase(url: "https://glaring-torch-8449.firebaseio.com/")
        let handle = ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
            } else {
                // No user is signed in
            }
        })
        
        // Setup delegates
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Attempt to sign in silently, this will succeed if
        // the user has recently been authenticated
        GIDSignIn.sharedInstance().signInSilently()
        
        authenticateWithGoogle()

    }
    
    // Wire up to a button tap
    func authenticateWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
        ref.unauth()
    }
    // Implement the required GIDSignInDelegate methods
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Auth with Firebase
                ref.authWithOAuthProvider("google", token: user.authentication.accessToken, withCompletionBlock: { (error, authData) in
                    // User is logged in!
                    // Create a new user dictionary accessing the user's info
                    // provided by the authData parameter
                    let newUser = [
                        "provider": authData.provider,
                        "displayName": authData.providerData["displayName"] as? NSString as? String
                    ]
        
                    self.ref.childByAppendingPath("users")
                        .childByAppendingPath(authData.uid).setValue(newUser)
                
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
            ref.unauth();
    }

    

}

