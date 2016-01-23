//
//  LoginWithClimateButton.swift
//  Pods
//
//  Created by Tommy Rogers on 1/21/16.
//
//

import Foundation
import UIKit

public class LoginWithClimateButton: UIViewController {

    override public func loadView() {
//        self.view.backgroundColor = UIColor.redColor()

        let button = UIButton(type: .System)
        button.setTitle("Login with Climate", forState: .Normal)
//        self.view.addSubview(button)

//        button.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = button.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
//        let verticalConstraint = button.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
//        horizontalConstraint.active = true
//        verticalConstraint.active = true

        button.addTarget(self, action: "loginWithClimate:", forControlEvents: .TouchUpInside)

        view = button
    }

    func loginWithClimate(sender: AnyObject) {
        print("Beginning LoginWithClimate")

        print(NSBundle(forClass: self.dynamicType))
        
        let storyboard = UIStoryboard(name: "Login", bundle: NSBundle(forClass: self.dynamicType))
        if let rootViewController = storyboard.instantiateInitialViewController() {
            self.presentViewController(rootViewController, animated: true, completion: nil)
        }
    }

}