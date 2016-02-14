//
//  ViewController.swift
//  houzie
//
//  Created by syahRiza on 2/8/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import UIKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if (isLoggedIn())
    {
      toDashboard()
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
  
  // MARK: Segue
  
  func toDashboard() {
    let chatController = self.storyboard?.instantiateViewControllerWithIdentifier("ChatController")
    self.presentViewController(chatController!, animated: true, completion: nil)
  }
  
  // MARK: FBSDKLoginButtonDelegate method overrides
  
  func isLoggedIn() -> Bool {
    return FBSDKAccessToken.currentAccessToken() != nil
  }
  
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    if (error != nil) {
      print(error.description)
    } else if result.isCancelled {
      print(result.description)
    } else {
      print("Success")
      
      let fbRequest = FBSDKGraphRequest(graphPath: "/me", parameters:["fields" : "id,name,picture.width(100).height(100)"])
      fbRequest.startWithCompletionHandler({ (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
        print(result.valueForKey("picture")!.valueForKey("data")!.valueForKey("url"))
      })
      toDashboard()
    }
  }
  
  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    print("Logged out")
  }
}

