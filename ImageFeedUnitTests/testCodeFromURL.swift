//
//  testCodeFromURL.swift
//  testCodeFromURL
//
//  Created by Toto Tsipun on 20.06.2023.
//

import XCTest
@testable import ImageFeed

final class testCodeFromURL: XCTestCase {
    
    func testCodeFromURL() {
        // given
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/authorize/native")!
        urlComponents.queryItems = [URLQueryItem(name: "code", value: "test code")]
        let url = urlComponents.url!
        let authHelper = AuthHelper()
        
        //when
        let code = authHelper.code(from: url)
        
        //then
        XCTAssertEqual(code, "test code")
    }
}
