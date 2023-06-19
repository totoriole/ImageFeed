//
//  ImagesListViewControllerSpy.swift
//  ImagesListViewTests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import Foundation
@testable import ImageFeed

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: ImagesListPresenterProtocol?
    var photos: [Photo]
    
    init(photos: [Photo]) {
        self.photos = photos
    }
    
    func isLike(indexPath: IndexPath, isOn: Bool) {
        
    }
    
    func showLikeAlert(with: Error) {
        
    }
    
    func didReceivePhotosForTableViewAnimatedUpdate(at indexPath: [IndexPath], new array: [ImageFeed.Photo]) {
        
    }
}
