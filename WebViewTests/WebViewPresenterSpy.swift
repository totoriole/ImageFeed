//
//  WebViewPresenterSpy.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 19.06.2023.
//

import Foundation

final class WebViewPresenterSpy: WebViewPresenterProtocol {

    var viewDidLoadCalled: Bool = false
    var view: WebViewViewControllerProtocol?

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func didUpdateProgressValue(_ newValue: Double) {

    }

    func code(from url: URL) -> String? {
        return nil
    }
}
