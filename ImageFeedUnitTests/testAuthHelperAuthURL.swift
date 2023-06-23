//
//  testAuthHelperAuthURL.swift
//  testAuthHelperAuthURL
//
//  Created by Toto Tsipun on 20.06.2023.
//

import XCTest
@testable import ImageFeed

final class testAuthHelperAuthURL: XCTestCase {

    func testAuthHelperAuthURL() {
        // given
        let configuration = AuthConfiguration.standart
        let authHelper = AuthHelper(configuration: configuration)
        
        // when
        let url = authHelper.authURL()
        let urlString = url.absoluteString
        
        // then
        XCTAssertTrue(urlString.contains(configuration.authURLString))
        XCTAssertTrue(urlString.contains(configuration.accessKey))
        XCTAssertTrue(urlString.contains(configuration.redirectURI))
        XCTAssertTrue(urlString.contains("code"))
        XCTAssertTrue(urlString.contains(configuration.accessScope))
    }
}
