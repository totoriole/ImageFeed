//
//  testPresenterCallsLoadRequest.swift
//  testProgressHiddenWhenOne
//
//  Created by Toto Tsipun on 20.06.2023.
//

import XCTest
@testable import ImageFeed

final class testPresenterCallsLoadRequest: XCTestCase {
    
    func testPresenterCallsLoadRequest() {
        // given
        let viewController = WebViewViewControllerSpy()
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = presenter
        presenter.view = viewController
        
        // when
        presenter.viewDidLoad()
        
        // then
        XCTAssertTrue(viewController.loadRequestCalled)
    }
}
