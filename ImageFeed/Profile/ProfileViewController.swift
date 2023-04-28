//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 27.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak private var photoProfileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var logoutButton: UIButton!
    
    @IBAction private func didTapLogoutButton() {
    }
}
