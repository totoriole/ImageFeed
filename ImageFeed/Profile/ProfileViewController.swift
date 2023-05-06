//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 27.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var photoProfileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var statusLabel: UILabel!
    private var logoutButton: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "YP Black")
        setupProfileImage(image: UIImage(named: "PhotoProfile"))
        setupLabels(name: "Екатерина Новикова", email: "@ekaterina_nov", status: "Hello, world!")
        setupButton()
    }
    
    private func setupProfileImage(image: UIImage?) {
        guard  let image = image else { return }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        self.photoProfileImageView = imageView
    }
    
    private func setupLabels(name: String, email: String, status: String) {
        let label1 = UILabel()
        label1.text = name
        label1.textColor = UIColor(named: "YP White")
        label1.font = .systemFont(ofSize: 23, weight: .bold)
        label1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = email
        label2.textColor = UIColor(named: "YP Grey")
        label2.font = UIFont(name: "SF Pro", size: 13)
        label2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label2)
        
        let label3 = UILabel()
        label3.text = status
        label3.textColor = UIColor(named: "YP White")
        label3.font = UIFont(name: "SF Pro", size: 13)
        label3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label3)
        
        NSLayoutConstraint.activate([
            label1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            label1.leadingAnchor.constraint(equalTo: photoProfileImageView.leadingAnchor),
            label1.topAnchor.constraint(equalTo: photoProfileImageView.bottomAnchor,constant: 8),
            
            label2.trailingAnchor.constraint(equalTo: label1.trailingAnchor),
            label2.leadingAnchor.constraint(equalTo: label1.leadingAnchor),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor,constant: 8),
            
            label3.trailingAnchor.constraint(equalTo: label2.trailingAnchor),
            label3.leadingAnchor.constraint(equalTo: label2.leadingAnchor),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor,constant: 8)
        ])
        self.nameLabel = label1
        self.emailLabel = label2
        self.statusLabel = label3
    }
    
    private func setupButton() {
        guard let imageButton = UIImage(named: "ipad.and.arrow.forward") else { return }
        let button = UIButton.systemButton(with: imageButton, target: self, action: nil)
        button.tintColor = UIColor(named: "YP Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55)
        ])
        self.logoutButton = button
    }
}

