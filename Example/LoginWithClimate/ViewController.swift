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
        
        listFieldNames(session.accessToken) {
            (fieldNames: [String]) in
            dispatch_async(dispatch_get_main_queue(), {
                self.label.text = "Welcome \(session.userInfo.firstName)\nYour fields are:\n\(fieldNames.prefix(12).joinWithSeparator("\n"))"
            })
        }
    }
    
    func listFieldNames(accessToken: String, onComplete completion: ([String] -> Void)) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://dmfhoydgci.execute-api.us-east-1.amazonaws.com/qa1/fields?includeBoundary=true")!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let names = (jsonObject["fields"] as! Array).map() {
                    (field: [String: AnyObject]) -> String in
                    return field["name"] as! String
                }
                
                completion(names)
            } catch let error as NSError {
                print("ERROR: deserializing JSON response: \(error.localizedDescription)")
                print("Body was: \(NSString(data: data!, encoding: NSUTF8StringEncoding))")
            }
        }
        
        task.resume()
    }
}

