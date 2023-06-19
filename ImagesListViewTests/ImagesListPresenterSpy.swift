//
//  ImagesListPresenterSpy.swift
//  ImagesListViewTests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import Foundation
@testable import ImageFeed

final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    
    var photos: [ImageFeed.Photo] = []
    var view: ImageFeed.ImagesListViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    var didFetchPhotosCalled: Bool = false
    var updateNextPageIfNeededCalled: Bool = false
    func selectLike(indexPath: IndexPath) {}

    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath) {
         updateNextPageIfNeededCalled = true
    }
}
