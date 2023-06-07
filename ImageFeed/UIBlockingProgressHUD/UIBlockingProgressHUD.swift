//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 31.05.2023.
//

import UIKit
import ProgressHUD

var progressHUD: Bool = false

final class UIBlockingProgressHUD {
    
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }

    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
        progressHUD = true
    }

    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
        progressHUD = false
    }
}
