//
//  LoginWithClimateButton.swift
//  Pods
//
//  Created by Tommy Rogers on 1/21/16.
//
//

import Foundation
import UIKit

public class LoginWithClimateButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addViews()
    }

    func addViews() {
        self.backgroundColor = UIColor.redColor()

        let button = UIButton(type: .System)
        button.setTitle("Login with Climate", forState: .Normal)
        self.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = button.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
        let verticalConstraint = button.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
        horizontalConstraint.active = true
        verticalConstraint.active = true

        button.addTarget(self, action: "loginWithClimate:", forControlEvents: .TouchUpInside)
    }

    func loginWithClimate(sender: AnyObject) {
        print("Beginning LoginWithClimate")
    }

}