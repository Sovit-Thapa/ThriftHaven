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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen

        if let userName = userName {
            print("User Name: \(userName)")
        }
        if let userEmail = userEmail {
            print("User Email: \(userEmail)")
        }

    }
}


