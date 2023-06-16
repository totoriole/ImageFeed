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
    
    func clean() {
       // Очищаем все куки из хранилища.
       HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
       // Запрашиваем все данные из локального хранилища.
       WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
          // Массив полученных записей удаляем из хранилища.
          records.forEach { record in
             WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
          }
       }
    }
}
