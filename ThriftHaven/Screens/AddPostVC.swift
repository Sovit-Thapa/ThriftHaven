//
//  AddPostVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class AddPostVC: UIViewController {

    let addPostLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(addPostLabel)
        configureAddPostLabel()
    }
    
    func configureAddPostLabel() {
        addPostLabel.text = "Add Post"
        NSLayoutConstraint.activate([
            addPostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            addPostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
