//
//  ViewController.swift
//  LoginWithClimate
//
//  Created by Tommy Rogers on 01/21/2016.
//  Copyright (c) 2016 Tommy Rogers. All rights reserved.
//

import UIKit
import LoginWithClimate

class ViewController: UIViewController {

    @IBOutlet var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginView = LoginWithClimateButton()
        contentView.addSubview(loginView)


        loginView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loginView]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loginView]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

