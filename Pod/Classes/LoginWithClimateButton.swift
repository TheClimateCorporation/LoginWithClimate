//
//  LoginWithClimateButton.swift
//  Pods
//
//  Created by Tommy Rogers on 1/21/16.
//
//

import Foundation
import UIKit

public protocol LoginWithClimateDelegate {
    func didLoginWithClimate(session: Session)
    func userDidCancelLoginWithClimate()
    func didFailLoginWithClimateWithError(error: NSError)
}

public extension LoginWithClimateDelegate {
    func userDidCancelLoginWithClimate() {}
    func didFailLoginWithClimateWithError(error: NSError) {}
}

public class LoginWithClimateButton: UIViewController, AuthorizationCodeDelegate {

    let oidc: OIDC
    public var delegate: LoginWithClimateDelegate?

    public init(clientId: String, clientSecret: String) {
        self.oidc = OIDC(clientId: clientId, clientSecret: clientSecret)
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override public func loadView() {
        let button = UIButton(type: .Custom)

        let img: UIImage = UIImage.init(named: "LoginWithClimateButton",
            inBundle: NSBundle.init(forClass: self.dynamicType),
            compatibleWithTraitCollection: nil)!

        button.setImage(img, forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFit

        button.addTarget(self, action: "loginWithClimate:", forControlEvents: .TouchUpInside)

        view = button
    }

    func loginWithClimate(sender: AnyObject) {
        print("Beginning LoginWithClimate")

        let storyboard = UIStoryboard(name: "Login", bundle: NSBundle(forClass: self.dynamicType))
        if let rootViewController = storyboard.instantiateInitialViewController() as? UINavigationController {
            if let webViewController = rootViewController.topViewController as? ClimateWebViewController {
                webViewController.delegate = self
                webViewController.oidc = self.oidc
            } else {
                print("ERROR: not a web view controller.")
            }
            self.presentViewController(rootViewController, animated: true, completion: nil)
        } else {
            print("ERROR: Failed to segue.")
        }
    }

    func didGetAuthorizationCode(code: String) {
        self.oidc.requestAuthToken(authorizationCode: code, onComplete: {
            (session: Session) in
            self.delegate?.didLoginWithClimate(session)
        })
    }
}