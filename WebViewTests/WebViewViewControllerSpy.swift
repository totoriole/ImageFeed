//
//  WebViewViewControllerSpy.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 19.06.2023.
//

import Foundation

final class  WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: ImageFeed.WebViewPresenterProtocol?
    var loadRequestCalled: Bool = false

    func load(request: URLRequest) {
        loadRequestCalled = true
    }

    func setProgressValue(_ newValue: Float) {

    }

    func setProgressHidden(_ isHidden: Bool) {

    }
}
