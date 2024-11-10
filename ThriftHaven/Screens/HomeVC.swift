//
//  HomeVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit
import Firebase

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    let slidersImageView = THImageView(frame: .zero)
    var imageArray = [UIImage]()
    var currentImageIndex = 0
    var imageChangeTimer: Timer?
    var userID: String?
    var userName: String?
    var userEmail: String?
    var userPhotoURL: URL?
    let homeLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    let categoriesLabel = THTitleLabel(textAlignment: .left, fontSize: 20)
    let userImageView = THImageView(frame: .zero)
    let arrowSFImageView = THImageView(frame: .zero)
    let latestProductsLabel = THTitleLabel(textAlignment: .left, fontSize: 20)
    let searchBar = UISearchBar()

    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var categories: [Category] = []
    var filteredCategories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        searchBar.placeholder = "Search for products"
        
        view.addSubview(searchBar)
        view.addSubview(homeLabel)
        view.addSubview(userImageView)
        view.addSubview(slidersImageView)
        view.addSubview(categoriesLabel)
        view.addSubview(arrowSFImageView)
        view.addSubview(categoryCollectionView)
        view.addSubview(latestProductsLabel)
        
        setupImageArray()
        configureSearchBar()
        configureHomeLabel()
        configureUserImage()
        configureSlidersImage()
        configureCategoriesLabel()
        configureArrowSFImageView()
        setupCategoryCollectionView()
        configureLatestProductsLabel()
        fetchCategories()
        setupKeyboardDismissal()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        startImageSlideshow()
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

    func configureHomeLabel() {
        homeLabel.text = "Home"
        NSLayoutConstraint.activate([
            homeLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            homeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func configureCategoriesLabel() {
        categoriesLabel.text = "Categories"
        NSLayoutConstraint.activate([
            categoriesLabel.topAnchor.constraint(equalTo: slidersImageView.bottomAnchor, constant: 10),
            categoriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
            userImageView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            userImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            userImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureLatestProductsLabel() {
        latestProductsLabel.text = "Latest Products"
        NSLayoutConstraint.activate([
            latestProductsLabel.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 5),
            latestProductsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    func configureArrowSFImageView() {
        arrowSFImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowSFImageView.image = UIImage(systemName: "arrow.right")
        arrowSFImageView.tintColor = .black
        
        NSLayoutConstraint.activate([
            arrowSFImageView.topAnchor.constraint(equalTo: slidersImageView.bottomAnchor, constant: 10),
            arrowSFImageView.leadingAnchor.constraint(equalTo: categoriesLabel.trailingAnchor),
            arrowSFImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            arrowSFImageView.heightAnchor.constraint(equalToConstant: 25),
            arrowSFImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
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
    
    func setupCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let totalWidth = UIScreen.main.bounds.width
            let itemWidth = totalWidth / 5
            let itemHeight: CGFloat = 100
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        }
        
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 15),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func fetchCategories() {
        CategoryService.shared.fetchCategories { [weak self] categories in
            self?.categories = categories
            self?.filteredCategories = categories
            DispatchQueue.main.async {
                self?.categoryCollectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = filteredCategories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }


        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
        }

        func setupKeyboardDismissal() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }

        @objc func dismissKeyboard() {
            searchBar.resignFirstResponder()
        }

}

