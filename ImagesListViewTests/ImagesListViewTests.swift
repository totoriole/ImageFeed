//
//  ImagesListViewTests.swift
//  ImagesListViewTests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import XCTest
@testable import ImageFeed

final class ImagesListViewTests: XCTestCase {

    func testViewControllerCallsViewDidLoad() {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testLike(){
        let photo: [Photo] = []
        let imagesListService = ImagesListService.shared
        let view = ImagesListViewControllerSpy(photos: photo)
        let presenter = ImagesListPresenterSpy()
        view.presenter = presenter
        presenter.view = view
        
        
    }
}
