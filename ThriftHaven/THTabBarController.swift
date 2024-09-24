import UIKit

class THTabBarController: UITabBarController {

    var userID: String!
    var userName: String!
    var userEmail: String!
    var userPhotoURL: URL?

    init(userID: String?, userName: String?, userEmail: String?, userPhotoURL: URL?) {
        self.userID = userID
        self.userName = userName
        self.userEmail = userEmail
        self.userPhotoURL = userPhotoURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("User Name: \(userName ?? "No User Name")")

        viewControllers = [
            createHomeVC(),
            createExploreVC(),
            createAddPostVC(),
            createUserDetailsVC(),
        ]
    }

    func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.userID = userID
        homeVC.userName = userName
        homeVC.userEmail = userEmail
        homeVC.userPhotoURL = userPhotoURL
        
        let homeImage = UIImage(systemName: "house.fill")
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.navigationBar.prefersLargeTitles = false 
        return navigationController
    }

    func createExploreVC() -> UINavigationController {
        let exploreVC = ExploreVC()
        exploreVC.title = "Explore"
        
        let searchImage = UIImage(systemName: "magnifyingglass")
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: searchImage, tag: 1)
        
        let navigationController = UINavigationController(rootViewController: exploreVC)
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }

    func createAddPostVC() -> UINavigationController {
        let addPostVC = AddPostVC()
        addPostVC.title = "Add Post"
        
        let addImage = UIImage(systemName: "plus.square.fill")
        addPostVC.tabBarItem = UITabBarItem(title: "Add Post", image: addImage, tag: 2)
        
        let navigationController = UINavigationController(rootViewController: addPostVC)
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }

    func createUserDetailsVC() -> UINavigationController {
        let userDetailsVC = UserDetailsVC()
        userDetailsVC.title = "Profile"
        userDetailsVC.userID = userID
        userDetailsVC.userName = userName
        userDetailsVC.userEmail = userEmail
        userDetailsVC.userPhotoURL = userPhotoURL
        
        let profileImage = UIImage(systemName: "person.fill")
        userDetailsVC.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 3)
        
        let navigationController = UINavigationController(rootViewController: userDetailsVC)
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }
}
