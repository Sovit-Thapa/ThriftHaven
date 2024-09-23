//
//  LoginVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class LoginVC: UIViewController {
    
    let loginImageView = THImageView(frame: .zero)
    let getStartedButton = THButton(backgroundColor: .systemBlue, title: "Get Started")
    let titleLabel = THTitleLabel(textAlignment: .left, fontSize: 24)
    let bodyLabel = THBodyLabel(textAlignment: .left)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loginImageView)
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(getStartedButton)
        configureLoginImage()
        configureButton()
        configureTitleLabel()
        configureBodyLabel()

        getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
    }
    
    @objc func getStartedButtonTapped() {
        let homeVC = THTabBarController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(homeVC, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: homeVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    func configureLoginImage() {
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            loginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginImageView.widthAnchor.constraint(equalToConstant: 420),
            loginImageView.heightAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.text = "Thrift Haven"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func configureBodyLabel() {
        bodyLabel.text = "Discover deals and find treasures, buy, sell and earn with ease !!"
        bodyLabel.font = UIFont.systemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func configureButton() {
        NSLayoutConstraint.activate([
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

