//
//  LoginWithClimateButton.swift
//  Pods
//
//  Created by Tommy Rogers on 1/21/16.
//
//

import Foundation
import UIKit

public class LoginWithClimateButton: UIViewController, AuthorizationCodeDelegate {

    override public func loadView() {
        let button = UIButton(type: .System)
        button.setTitle("Login with Climate", forState: .Normal)
        button.addTarget(self, action: "loginWithClimate:", forControlEvents: .TouchUpInside)

        view = button
    }

    func loginWithClimate(sender: AnyObject) {
        print("Beginning LoginWithClimate")

        print(NSBundle(forClass: self.dynamicType))
        
        let storyboard = UIStoryboard(name: "Login", bundle: NSBundle(forClass: self.dynamicType))
        if let rootViewController = storyboard.instantiateInitialViewController() as? UINavigationController {
            if let webViewController = rootViewController.topViewController as? ClimateWebViewController {
                print("Web view controller.")
                webViewController.delegate = self
            } else {
                print("NOT a web view controller.")
            }
            self.presentViewController(rootViewController, animated: true, completion: nil)
        } else {
            print("Failed to segue.")
        }
    }

    func didGetAuthorizationCode(code: String) {
        print("Authorization code is: \(code)")
    }

    func requestAuthToken(authorizationCode: String, clientId: String, clientSecret: String) {
//        let url = NSURL("https://qa1.climate.com/api/oauth/token")
    }
}