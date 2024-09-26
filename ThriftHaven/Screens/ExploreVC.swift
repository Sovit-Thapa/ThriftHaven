//
//  ExploreVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class ExploreVC: UIViewController {

    let exploreLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(exploreLabel)
        configureExploreLabel()
    }
    
    func configureExploreLabel() {
        exploreLabel.text = "Explore"
        NSLayoutConstraint.activate([
            exploreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            exploreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
