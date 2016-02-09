//
//  ViewController.swift
//  houzie
//
//  Created by syahRiza on 2/8/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import UIKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isLoggedIn())
        {
            // User is already logged in
        }
        else
        {
            let fbLoginButton = FBSDKLoginButton()
            self.view.addSubview(fbLoginButton)
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: 350)
            fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
            fbLoginButton.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isLoggedIn() -> Bool {
        if FBSDKAccessToken.currentAccessToken() != nil {
            return true
        }
        return false
    }
 
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil) {
            print(error.description)
        } else if result.isCancelled {
            print(result.description)
        } else {
            print("Success")
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Logged out")
    }
}

