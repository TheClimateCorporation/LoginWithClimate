//
//  ViewController.swift
//  LoginWithClimate
//
//  Created by Tommy Rogers on 01/21/2016.
//  Copyright (c) 2016 Tommy Rogers. All rights reserved.
//

import UIKit
import LoginWithClimate

class ViewController: UIViewController, LoginWithClimateDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginViewController = LoginWithClimateButton(clientId: "devportalsample", clientSecret: "")
        loginViewController.delegate = self

        contentView.addSubview(loginViewController.view)

        loginViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loginViewController.view]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loginViewController.view]))

        self.addChildViewController(loginViewController)
    }

    func didLoginWithClimate(session: Session) {
        print(session.accessToken)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.label.text = "Welcome \(session.userInfo.firstName)"
        })
        
    }
}

