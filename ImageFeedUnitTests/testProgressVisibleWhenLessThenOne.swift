//
//  testProgressVisibleWhenLessThenOne.swift
//  testProgressVisibleWhenLessThenOne
//
//  Created by Toto Tsipun on 20.06.2023.
//

import XCTest
@testable import ImageFeed

final class testProgressVisibleWhenLessThenOne: XCTestCase {

    func testProgressVisibleWhenLessThenOne() {
        // given
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6
        
        //when
        let sholdHideProgress = presenter.shouldHideProgress(for: progress)
        
        //then
        XCTAssertFalse(sholdHideProgress)
    }
}
