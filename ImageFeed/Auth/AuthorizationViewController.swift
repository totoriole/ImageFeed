//
//  Authorization.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 15.05.2023.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthorizationViewController, didAuthenticateWithCode code: String)
}

final class AuthorizationViewController: UIViewController {
    
    weak var delegate: AuthViewControllerDelegate?
    
    private let idSegueWebView = "ShowWebView"
    @IBOutlet private weak var loginButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == idSegueWebView {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(idSegueWebView)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension AuthorizationViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
