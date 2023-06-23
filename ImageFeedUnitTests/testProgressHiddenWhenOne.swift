//
//  testProgressHiddenWhenOne.swift
//  testProgressHiddenWhenOne
//
//  Created by Toto Tsipun on 20.06.2023.
//

import XCTest
@testable import ImageFeed

final class testProgressHiddenWhenOne: XCTestCase {
    
    func testProgressHiddenWhenOne() {
        //given
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1.0
        
        //when
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        //then
        XCTAssertTrue(shouldHideProgress)
    }
}
