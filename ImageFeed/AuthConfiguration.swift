//
//  Constants.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 11.05.2023.
//

import Foundation
import UIKit

//let AccessKey = "6lvoxqWUx3UNIbC2xIICMOiCDEOfIRn07rJn-LbitUg"
let AccessKey = "FJT0f-zwo9RMzLcWx0dnkSEoU4nHd2pD7S-su74EuEs"
//let SecretKey = "k2yFxWba5B0i0TEJZMwM1u_lMi52LOxuhhArKjHzw7k"
let SecretKey = "XWKQO62QQ_GygiNLx-4rYBS864_TUWoikfCq6vbiLpo"
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = URL(string: "https://api.unsplash.com/")!
let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String

    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, defaultBaseURL: URL, authURLString: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }

    static var standart: AuthConfiguration {
        return AuthConfiguration(
            accessKey: AccessKey,
            secretKey: SecretKey,
            redirectURI: RedirectURI,
            accessScope: AccessScope,
            defaultBaseURL: DefaultBaseURL,
            authURLString: UnsplashAuthorizeURLString)
    }
}
