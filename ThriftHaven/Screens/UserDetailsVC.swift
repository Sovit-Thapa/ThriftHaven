//
//  UserDetailsVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit
import GoogleSignIn

class UserDetailsVC: UIViewController {

    var userID: String?
    var userName: String?
    var userEmail: String?
    var userPhotoURL: URL?

    let myProfileLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    let profileImageView = UIImageView()
    let userNameLabel = THTitleLabel(textAlignment: .center, fontSize: 20)
    let userEmailLabel = THBodyLabel(textAlignment: .center)
    let logOutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(myProfileLabel)
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(logOutButton)
        
        configureMyProfileLabel()
        configureProfileImageView()
        configureUserNameLabel()
        configureUserEmailLabel()
        configureLogOutButton()
        
        loadUserProfileImage()
        updateUserInfo()
    }
    
    func configureMyProfileLabel() {
        myProfileLabel.text = "My Profile"
        myProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myProfileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func configureProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 75
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.systemGray.cgColor

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: myProfileLabel.bottomAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }

    func configureUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func configureUserEmailLabel() {
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        userEmailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        NSLayoutConstraint.activate([
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userEmailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func configureLogOutButton() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.backgroundColor = .systemRed
        logOutButton.layer.cornerRadius = 10
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        logOutButton.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)

        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 30),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 200),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func loadUserProfileImage() {
        guard let userPhotoURL = userPhotoURL else {
            profileImageView.image = UIImage(systemName: "person.circle")
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: userPhotoURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
    }
    
    func updateUserInfo() {
        userNameLabel.text = userName ?? "Unknown User"
        userEmailLabel.text = userEmail ?? "Email not available"
    }

    @objc func handleLogOut() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            GIDSignIn.sharedInstance.signOut()

            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            self?.present(loginVC, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
