//
//  OIDC.swift
//  Pods
//
//  Created by Tommy Rogers on 1/25/16.
//
//

import Foundation

class OIDC {

    let clientId: String
    let clientSecret: String

    init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }


    // MARK: - Related to login page

    let loginPageURL = "https://qa1.climate.com/static/auth-pages/index.html"
    let loginPageStaticParams = [
        "page": "oidcauthn",
        "response_type": "code",
        "redirect_uri": "done:",
        "scope": "openid user"
    ]

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


    // MARK: - Related to token call

    let allowableFormCharacters: NSCharacterSet = {
        var set = NSCharacterSet.alphanumericCharacterSet().mutableCopy()
        set.addCharactersInString(".-_~:")
        return set.copy() as! NSCharacterSet
    }()

    let tokenURL = NSURL(string: "https://qa1.climate.com/api/oauth/token")!
    let tokenCallStaticParams = [
        "grant_type": "authorization_code",
        "scope": "user openid",
        "redirect_uri": "done:"
    ]

    func formEncodedString(dict: [String: String]) -> String {
        let escape = { (x: String) -> String in x.stringByAddingPercentEncodingWithAllowedCharacters(self.allowableFormCharacters)! }
        return dict.map({(k, v) in "\(escape(k))=\(escape(v))"}).joinWithSeparator("&")
    }

    func basicAccessHeader(principal principal: String, credential: String) -> String {
        let base64String = "\(principal):\(credential)".dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return "Basic \(base64String)"
    }

    func constructTokenRequest(authorizationCode: String, clientId: String, clientSecret: String) -> NSURLRequest {
        let request = NSMutableURLRequest(URL: self.tokenURL)
        request.HTTPMethod = "POST"

        var params = self.tokenCallStaticParams
        params["code"] = authorizationCode
        request.HTTPBody = self.formEncodedString(params).dataUsingEncoding(NSUTF8StringEncoding)

        request.setValue(self.basicAccessHeader(principal: clientId, credential: clientSecret), forHTTPHeaderField: "Authorization")

        return request
    }

    func requestAuthToken(authorizationCode code: String) {
        let request = self.constructTokenRequest(code, clientId: self.clientId, clientSecret: self.clientSecret)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(jsonObject)
            } catch let error as NSError {
                print("ERROR: deserializing JSON response: \(error.localizedDescription)")
                print("Body was: \(NSString(data: data!, encoding: NSUTF8StringEncoding))")
            }
        }

        task.resume()
    }

}