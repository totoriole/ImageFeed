//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 22.05.2023.
//

import UIKit

class OAuth2TokenStorage {
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token") ?? nil
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
}
