//
//  ExploreVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class ExploreVC: UIViewController, UISearchBarDelegate {

    let searchBar = UISearchBar()
    let exploreLabel = THTitleLabel(textAlignment: .left, fontSize: 28)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        searchBar.delegate = self
        searchBar.placeholder = "Search for products"
        view.addSubview(searchBar)

        view.addSubview(exploreLabel)
        configureExploreLabel()
        
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configureExploreLabel() {
        exploreLabel.text = "Explore"
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exploreLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            exploreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

