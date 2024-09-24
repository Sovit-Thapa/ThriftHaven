//
//  HomeVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class HomeVC: UIViewController {

    let slidersImageView = THImageView(frame: .zero)
    var imageArray = [UIImage]()
    var currentImageIndex = 0
    var imageChangeTimer: Timer?
    var userID: String?
    var userName: String?
    var userEmail: String?
    var userPhotoURL: URL?
    let homeLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    let userImageView = THImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let userName = userName {
            print("Welcome, \(userName)")
        }
        view.addSubview(homeLabel)
        view.addSubview(userImageView)
        view.addSubview(slidersImageView)
        configureHomeLabel()
        setupImageArray()
        configureUserImage()
        configureSlidersImage()
        startImageSlideshow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
        startImageSlideshow()
    }
    
    func configureHomeLabel() {
        homeLabel.text = "Home"
        NSLayoutConstraint.activate([
            homeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            homeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func configureUserImage() {
        guard let userPhotoURL = userPhotoURL else {
            userImageView.image = UIImage(named: "defaultProfileImage")
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: userPhotoURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.userImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.userImageView.image = UIImage(named: "defaultProfileImage")
                }
            }
        }

        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.cornerRadius = 25
        userImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            userImageView.leadingAnchor.constraint(equalTo: homeLabel.trailingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            userImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        imageChangeTimer?.invalidate()
    }

    func setupImageArray() {
        if let sale1 = Images.sale1,
           let sale2 = Images.sale2,
           let sale3 = Images.sale3,
           let sale4 = Images.sale4 {
            imageArray = [sale1, sale2, sale3, sale4]
        } else {
            print("One or more images could not be loaded")
        }
    }

    func configureSlidersImage() {
        slidersImageView.image = imageArray.first
        slidersImageView.contentMode = .scaleToFill
        slidersImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slidersImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            slidersImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            slidersImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            slidersImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func startImageSlideshow() {
        imageChangeTimer?.invalidate()
        imageChangeTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    @objc func changeImage() {
        currentImageIndex = (currentImageIndex + 1) % imageArray.count
        slidersImageView.image = imageArray[currentImageIndex]
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageChangeTimer?.invalidate()
    }
}
