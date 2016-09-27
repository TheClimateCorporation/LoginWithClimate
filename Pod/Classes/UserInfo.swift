//
//  UserInfo.swift
//  Pods
//
//  Created by Tommy Rogers on 1/26/16.
//
//

import Foundation

public class Session {

    public let accessToken: String!
    public let expiresIn: Int!
    public let scope: String!

    public let userInfo: UserInfo!

    public init?(dictionary: [String: AnyObject]) {
        guard let accessToken = dictionary["access_token"] as? String,
            let expiresIn = dictionary["expires_in"] as? Int,
            let scope = dictionary["scope"] as? String,
            let userDict = dictionary["user"] as? [String: AnyObject],
            let userInfo = UserInfo(dictionary: userDict)
        else {
            return nil
        }

        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.scope = scope
        self.userInfo = userInfo
    }
}

public class UserInfo {

    public let id: Int

    public let email: String
    public let firstName: String
    public let lastName: String

    public let roles: [String]

    public let address1: String?
    public let address2: String?
    public let zip: String?

    public let country: String?
    public let city: String?
    public let state: String?

    public let phone: String?

    public init?(dictionary: [String: AnyObject]) {
        guard let id = dictionary["id"] as? Int,
                let firstName = dictionary["firstname"] as? String,
                let lastName = dictionary["lastname"] as? String,
                let email = dictionary["email"] as? String
        else {
            return nil
        }

        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName

        self.roles = (dictionary["roles"] as? [String]) ?? []

        self.address1 = dictionary["address1"] as? String
        self.address2 = dictionary["address2"] as? String
        self.zip = dictionary["zip"] as? String
        self.country = dictionary["country"] as? String
        self.city = dictionary["city"] as? String
        self.state = dictionary["state"] as? String
        self.phone = dictionary["phone"] as? String
    }
}
