//
//  ClimateWebViewController.swift
//  Pods
//
//  Created by Tommy Rogers on 1/21/16.
//
//

import Foundation
import UIKit

class ClimateWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!

    let loginPageQueryParams: [NSURLQueryItem] = [ "page": "oidcauthn",
                                 "client_id": "authorize",
                                 "response_type": "code",
                                 "redirect_uri": "done:",
                                 "scope": "openid user"
                               ].map({(k, v) in NSURLQueryItem(name: k, value: v) })

    override func viewDidLoad() {

        let l = NSURLComponents(string: "https://qa1.climate.com/static/auth-pages/index.html")!
        l.queryItems = loginPageQueryParams
        let loginPageURL = l.URL!

        print(loginPageURL)

        webView.delegate = self

        webView.loadRequest(NSURLRequest(URL: loginPageURL))
        webView.scrollView.scrollEnabled = false
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        if (error?.code == NSURLErrorCancelled || error?.code == 102 || error?.code == 101) {
            return
        }

        print("Webview failed to load with error: \(error)")

    }

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request)
        print(request.URL?.host)

        // TODO can this all happen on this thread before returning?
        if (request.URL?.scheme == "done") {
            self.dismissViewControllerAnimated(true, completion: nil)
            if let queryItems = NSURLComponents(URL: request.URL!, resolvingAgainstBaseURL: false)?.queryItems {
                let code = queryItems.filter({(item) -> Bool in item.name == "code"}).first
                print("Authorization code is: \(code)")
                print("")
            }

            request.URL?.query
        }

        return true
    }

}