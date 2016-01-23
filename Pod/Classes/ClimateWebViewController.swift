//
//  ClimateWebViewController.swift
//  Pods
//
//  Created by Tommy Rogers on 1/21/16.
//
//

import Foundation
import UIKit

class ClimateWebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!

    let loginPageQueryParams = [ "page": "oidcauthn",
                                 "client_id": "authorize",
                                 "response_type": "code",
                                 "redirect_uri": "https://woo/ha",
                                 "scope": "openid user"
                               ]

    override func viewDidLoad() {

        let l = NSURLComponents(string: "https://qa1.climate.com/static/auth-pages/index.html")!
        l.queryItems = loginPageQueryParams.map({(k, v) in NSURLQueryItem(name: k, value: v) })
        let loginPageURL = l.URL!

        print(loginPageURL)

        webView.loadRequest(NSURLRequest(URL: loginPageURL))
        webView.scrollView.scrollEnabled = false
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}