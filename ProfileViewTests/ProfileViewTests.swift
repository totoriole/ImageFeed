//
//  ProfileViewTests.swift
//  ProfileViewTests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import XCTest
@testable import ImageFeed

final class ProfileViewTests: XCTestCase {

    func testViewControllerCallsViewDidLoad(){
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        // when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testProfileViewCallsLogout() {
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        // When
        presenter.logOut()
        
        XCTAssertTrue(presenter.logOutCalled)
    }
}
