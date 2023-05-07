//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 27.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var photoProfileImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PhotoProfile"))
        return image
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = UIColor(named: "YP White")
        label.font = .systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = UIColor(named: "YP Grey")
        label.font = UIFont(name: "SF Pro", size: 13)
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        label.textColor = UIColor(named: "YP White")
        label.font = UIFont(name: "SF Pro", size: 13)
        return label
    }()
    private lazy var logoutButton: UIButton = {
//        guard let imageButton = UIImage(named: "ipad.and.arrow.forward") else { return }
        let button = UIButton(type: .system)
        if let imageButton = UIImage(named: "ipad.and.arrow.forward") {
            button.setImage(imageButton, for: .normal)
        }
        button.tintColor = UIColor(named: "YP Red")
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "YP Black")
        setupProfileImage()
        setupLabels()
        setupButton()
    }
    
    private func setupProfileImage() {
        photoProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoProfileImageView)
        NSLayoutConstraint.activate([
            photoProfileImageView.widthAnchor.constraint(equalToConstant: 70),
            photoProfileImageView.heightAnchor.constraint(equalToConstant: 70),
            photoProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            photoProfileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupLabels() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: photoProfileImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: photoProfileImageView.bottomAnchor,constant: 8),
            
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 8),
            
            statusLabel.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,constant: 8)
        ])
    }
    
    private func setupButton() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55)
        ])
    }
}

