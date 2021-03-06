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

    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginViewController = LoginWithClimateButton(clientId: "REPLACE ME", clientSecret: "REPLACE ME")
        loginViewController.delegate = self

        view.addSubview(loginViewController.view)
        
        loginViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["view":loginViewController.view]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loginViewController.view]))

        self.addChildViewController(loginViewController)
    }

    func didLoginWithClimate(session: Session) {
        print(session.accessToken)
        
        listFieldNames(session.accessToken) {
            (fieldNames: [String]) in
            dispatch_async(dispatch_get_main_queue(), {
                self.label.text = "Welcome \(session.userInfo.firstName)\nYour fields are:\n\(fieldNames.prefix(12).joinWithSeparator("\n"))"
            })
        }
    }
    
    func listFieldNames(accessToken: String, onComplete completion: ([String] -> Void)) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://hack.climate.com/api/fields?includeBoundary=true")!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                if let fields = jsonObject["fields"] as? [[String: AnyObject]] {
                    let names = fields.map() {
                        (field: [String: AnyObject]) -> String in
                        return field["name"] as! String
                    }
                    completion(names)
                } else {
                    print("ERROR: \(NSString(data:data!, encoding:NSUTF8StringEncoding))")
                }
                
            } catch let error as NSError {
                print("ERROR: deserializing JSON response: \(error.localizedDescription)")
                print("Body was: \(NSString(data: data!, encoding: NSUTF8StringEncoding))")
            }
        }
        
        task.resume()
    }
}

