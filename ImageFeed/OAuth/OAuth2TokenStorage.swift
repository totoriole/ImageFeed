//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 22.05.2023.
//

import UIKit
import SwiftKeychainWrapper
import WebKit

class OAuth2TokenStorage {
    
    static let shared = OAuth2TokenStorage()
    private let keyChain = KeychainWrapper.standard
    
    var token: String? {
        get {
            keyChain.string(forKey: "bearerToken")
        }
        set {
            if let token = newValue {
                keyChain.set(token, forKey: "bearerToken")
            } else {
                keyChain.removeObject(forKey: "bearerToken")
                
            }
        }
    }
}
