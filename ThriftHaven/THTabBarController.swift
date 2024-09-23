//
//  THTabBarController.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class THTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the tab bar with view controllers
        viewControllers = [
            createHomeVC(),
            createExploreVC(),
            createAddPostVC(),
            createUserDetailsVC(),
        ]
    }
    
    func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        let homeImage = UIImage(systemName: "house.fill") // SF Symbol for Home
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createExploreVC() -> UINavigationController {
        let exploreVC = ExploreVC()
        exploreVC.title = "Explore"
        let searchImage = UIImage(systemName: "magnifyingglass") // SF Symbol for Search
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: searchImage, tag: 1)
        return UINavigationController(rootViewController: exploreVC)
    }
    
    func createAddPostVC() -> UINavigationController {
        let addPostVC = AddPostVC()
        addPostVC.title = "Add Post"
        let addImage = UIImage(systemName: "plus.square.fill") // SF Symbol for Add
        addPostVC.tabBarItem = UITabBarItem(title: "Add Post", image: addImage, tag: 2)
        return UINavigationController(rootViewController: addPostVC)
    }
    
    func createUserDetailsVC() -> UINavigationController {
        let userDetailsVC = UserDetailsVC()
        userDetailsVC.title = "Profile"
        let profileImage = UIImage(systemName: "person.fill") // SF Symbol for Profile
        userDetailsVC.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 3)
        return UINavigationController(rootViewController: userDetailsVC)
    }
}

