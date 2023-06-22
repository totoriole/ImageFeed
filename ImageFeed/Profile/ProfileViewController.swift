//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 27.04.2023.
//

import UIKit
import Kingfisher
import WebKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? {get set}
    
    func updateAvatar()
    func didTapLogOutButton()
    func alert(title: String, message: String, action: ((UIAlertAction) -> ())?)
    func configureViews()
    func configureConstraints()
    func updateProfileDetails(profile: Profile?)
    func updateRootViewControler()
}

final class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    
    var presenter: ProfilePresenterProtocol?
    private var profileImageServiceObserver: NSObjectProtocol?
    private var authToken = OAuth2TokenStorage()
    private let profileService = ProfileService.shared
    private let profileImage = UIImage(named: "PhotoProfile")
    
    private lazy var photoProfileImageView: UIImageView = {
        let imageView = UIImageView(image: profileImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.accessibilityIdentifier = "ProfileNameLabel"
        label.textColor = UIColor(named: "YP White")
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.accessibilityIdentifier = "ProfileLoginNameLabel"
        label.textColor = UIColor(named: "YP Grey")
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        label.textColor = UIColor(named: "YP White")
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton : UIButton = {
        guard let image = UIImage(systemName: "ipad.and.arrow.forward") else {
            assert(false, "Failed to create button image")
            assertionFailure("Failed to create button image")
            //            fatalError("Failed to create button image")
        }
        let imageButton  = UIButton.systemButton(with: image, target: self, action: #selector(self.didTapLogOutButton))
        imageButton.accessibilityIdentifier = "ProfileExitButton"
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.tintColor = UIColor(named: "YP Red")
        return imageButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        presenter?.viewDidLoad()
    }
    
    // MARK: - Functions
    
    internal func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL) else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 35)
        photoProfileImageView.kf.indicatorType = .activity
        photoProfileImageView.kf.setImage(with: url,
                                          placeholder: UIImage(named: "placeholder.jpeg"),
                                          options: [.processor(processor),.cacheSerializer(FormatIndicatedCacheSerializer.png)])
        let cache = ImageCache.default
        cache.clearDiskCache()
        cache.clearMemoryCache()
        
    }
    
    internal func configureViews() {
        view.addSubview(photoProfileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(statusLabel)
        view.addSubview(logoutButton)
    }
    
    internal func configureConstraints() {
        NSLayoutConstraint.activate([
            photoProfileImageView.widthAnchor.constraint(equalToConstant: 70),
            photoProfileImageView.heightAnchor.constraint(equalToConstant: 70),
            photoProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            photoProfileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: photoProfileImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: photoProfileImageView.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: photoProfileImageView.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: photoProfileImageView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            logoutButton.centerYAnchor.constraint(equalTo: photoProfileImageView.centerYAnchor)
        ])
    }
    
    internal func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else {return}
        self.nameLabel.text = profile.name
        self.emailLabel.text = profile.loginName
        self.statusLabel.text = profile.bio
    }
    
    @objc
    internal func didTapLogOutButton() {
        presenter?.logOut()
    }
    
    func alert(title: String, message: String, action: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default, handler: action)
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Delegate Presenter
extension ProfileViewController {
    func updateRootViewControler() {
        guard let window = UIApplication.shared.windows.first else {fatalError("Invalid Configuration")}
        window.rootViewController = SplashViewController()
        window.makeKeyAndVisible()
    }
}
