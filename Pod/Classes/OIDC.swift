//
//  OIDC.swift
//  Pods
//
//  Created by Tommy Rogers on 1/25/16.
//
//

import Foundation

class OIDC {

    let loginPageURL = "https://qa1.climate.com/static/auth-pages/index.html"
    let loginPageStaticParams = [
        "page": "oidcauthn",
        "response_type": "code",
        "redirect_uri": "done:",
        "scope": "openid user"
    ]

    let clientId: String

    init(clientId: String) {
        self.clientId = clientId
    }

    func loginPageURLWithParams() -> NSURL {
        let l = NSURLComponents(string: self.loginPageURL)!

        var queryItems = self.loginPageStaticParams.map({(k, v) in NSURLQueryItem(name: k, value: v) })
        queryItems.append(NSURLQueryItem(name: "client_id", value: self.clientId))

        l.queryItems = queryItems
        return l.URL!
    }

    func isRedirectURL(url: NSURL) -> Bool {
        return url.scheme == "done"
    }
}