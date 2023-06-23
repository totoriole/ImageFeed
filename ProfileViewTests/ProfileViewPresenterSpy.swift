//
//  ProfileViewPresenterSpy.swift
//  ProfileViewTests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import Foundation
@testable import ImageFeed

final class ProfileViewPresenterSpy: ProfilePresenterProtocol {
    var view: ImageFeed.ProfileViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    var logOutCalled: Bool = false
    
    func setNotificationObserver() {
        
    }
    
    func viewDidLoad(){
        viewDidLoadCalled = true
    }
    
    func logOut() {
        logOutCalled = true
    }
}
