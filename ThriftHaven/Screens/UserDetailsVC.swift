//
//  UserDetailsVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class UserDetailsVC: UIViewController {

    var userID: String?
    var userName: String?
    var userEmail: String?
    var userPhotoURL: URL?

    let myProfileLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(myProfileLabel)
        configureMyProfileLabel()
    }
    
    func configureMyProfileLabel() {
        myProfileLabel.text = "My Profile"
        NSLayoutConstraint.activate([
            myProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            myProfileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}


