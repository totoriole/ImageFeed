//
//  ProfileViewControllerSpy.swift
//  ProfileViewTests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import Foundation
import UIKit
@testable import ImageFeed

final class ProfileViewControllerSpy: UIAlertAction, ProfileViewControllerProtocol {
    
    var presenter: ImageFeed.ProfilePresenterProtocol?
    var setAvatarCalls = false
    
    func updateAvatar() {
        setAvatarCalls = true
    }
    
    func didTapLogOutButton() {
        
    }
    
    func alert(title: String, message: String, action: ((UIAlertAction) -> ())?) {
        
    }
    
    func configureViews() {
        
    }
    
    func setUpGradient() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func updateProfileDetails(profile: ImageFeed.Profile?) {
        
    }
    
    func updateRootViewControler() {
        
    }
}
