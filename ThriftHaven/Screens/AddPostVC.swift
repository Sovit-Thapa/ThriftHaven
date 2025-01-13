//
//  AddPostVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

//import UIKit
//import FirebaseFirestore
//import FirebaseStorage
//
//class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
//
//    let addPostLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
//    let selectedImageView = UIImageView()
//    var selectedImage: UIImage?
//    let titleTextField = UITextField()
//    let descriptionTextView = UITextView()
//    let priceTextField = UITextField()
//    let addressTextField = UITextField()
//    let categoryButton = UIButton()
//    var categories: [Category] = []
//    let submitButton = UIButton()
//    let db = Firestore.firestore()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        
//        view.addSubview(addPostLabel)
//        configureAddPostLabel()
//        setupSelectedImageView()
//        displayPlaceholderImage()
//        
//        setupTitleTextField()
//        setupDescriptionTextView()
//        setupPriceTextField()
//        setupAddressTextField()
//        setupCategoryButton()
//        setupSubmitButton()
//        fetchCategories()
//    }
//
//    func configureAddPostLabel() {
//        addPostLabel.text = "Add Post"
//        addPostLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            addPostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            addPostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//        ])
//    }
//
//    func setupSelectedImageView() {
//        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
//        selectedImageView.contentMode = .scaleAspectFill
//        selectedImageView.clipsToBounds = true
//        selectedImageView.layer.cornerRadius = 10
//        selectedImageView.layer.borderColor = UIColor.systemGray.cgColor
//        selectedImageView.layer.borderWidth = 1
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
//        selectedImageView.addGestureRecognizer(tapGesture)
//        selectedImageView.isUserInteractionEnabled = true
//        
//        view.addSubview(selectedImageView)
//
//        NSLayoutConstraint.activate([
//            selectedImageView.topAnchor.constraint(equalTo: addPostLabel.bottomAnchor, constant: 20),
//            selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            selectedImageView.widthAnchor.constraint(equalToConstant: 120),
//            selectedImageView.heightAnchor.constraint(equalToConstant: 120)
//        ])
//    }
//    
//    func displayPlaceholderImage() {
//        let placeholderImage = UIImage(systemName: "photo")
//        selectedImageView.image = placeholderImage
//        selectedImageView.tintColor = .systemGray
//    }
//
//    func styleTextField(_ textField: UITextField, placeholder: String) {
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = placeholder
//        textField.borderStyle = .none
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.systemGray.cgColor
//        textField.layer.cornerRadius = 8
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.setLeftPaddingPoints(10) // Helper to add padding
//    }
//
//    func setupTitleTextField() {
//        styleTextField(titleTextField, placeholder: "Enter title")
//        view.addSubview(titleTextField)
//        
//        NSLayoutConstraint.activate([
//            titleTextField.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 20),
//            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            titleTextField.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//    
//    func setupDescriptionTextView() {
//        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
//        descriptionTextView.layer.borderWidth = 1
//        descriptionTextView.layer.borderColor = UIColor.systemGray.cgColor
//        descriptionTextView.layer.cornerRadius = 8
//        descriptionTextView.text = "Enter description..."
//        descriptionTextView.textColor = .systemGray
//        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
//        descriptionTextView.delegate = self
//        view.addSubview(descriptionTextView)
//        
//        NSLayoutConstraint.activate([
//            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
//            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            descriptionTextView.heightAnchor.constraint(equalToConstant: 100)
//        ])
//    }
//
//    func setupPriceTextField() {
//        styleTextField(priceTextField, placeholder: "Enter price")
//        priceTextField.keyboardType = .decimalPad
//        view.addSubview(priceTextField)
//        
//        NSLayoutConstraint.activate([
//            priceTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
//            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            priceTextField.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//
//    func setupAddressTextField() {
//        styleTextField(addressTextField, placeholder: "Enter address")
//        view.addSubview(addressTextField)
//        
//        NSLayoutConstraint.activate([
//            addressTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 15),
//            addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            addressTextField.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//
//    func setupCategoryButton() {
//        categoryButton.translatesAutoresizingMaskIntoConstraints = false
//        categoryButton.setTitle("Select a category", for: .normal)
//        categoryButton.setTitleColor(.systemBlue, for: .normal)
//        categoryButton.backgroundColor = .systemGray6
//        categoryButton.layer.cornerRadius = 8
//        categoryButton.layer.borderWidth = 1
//        categoryButton.layer.borderColor = UIColor.systemGray.cgColor
//        categoryButton.addTarget(self, action: #selector(showCategoryMenu), for: .touchUpInside)
//        view.addSubview(categoryButton)
//        
//        NSLayoutConstraint.activate([
//            categoryButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 15),
//            categoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            categoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            categoryButton.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//
//    @objc func showCategoryMenu() {
//        let menuItems = categories.map { category in
//            UIAction(title: category.name, handler: { [weak self] _ in
//                self?.categoryButton.setTitle(category.name, for: .normal)
//            })
//        }
//
//        let menu = UIMenu(title: "", options: .displayInline, children: menuItems)
//        categoryButton.menu = menu
//        categoryButton.showsMenuAsPrimaryAction = true
//    }
//    
//    func setupSubmitButton() {
//        submitButton.translatesAutoresizingMaskIntoConstraints = false
//        submitButton.setTitle("Submit", for: .normal)
//        submitButton.backgroundColor = .systemBlue
//        submitButton.setTitleColor(.white, for: .normal)
//        submitButton.layer.cornerRadius = 8
//        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
//        view.addSubview(submitButton)
//        
//        NSLayoutConstraint.activate([
//            submitButton.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 20),
//            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            submitButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    @objc func pickImage() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            selectedImage = image
//            selectedImageView.image = selectedImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func fetchCategories() {
//        CategoryService.shared.fetchCategories { [weak self] categories in
//            self?.categories = categories
//        }
//    }
//    
//    func uploadImageDataToFirebase(imageData: Data, completion: @escaping (String?) -> Void) {
//        // Create a reference to Firebase Storage
//        let storageRef = Storage.storage().reference().child("postImages/\(UUID().uuidString).jpg")
//        
//        // Upload the image data
//        storageRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                print("Error uploading image: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//            
//            // Get the image URL after upload
//            storageRef.downloadURL { url, error in
//                if let error = error {
//                    print("Error getting image URL: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                }
//                
//                completion(url?.absoluteString)
//            }
//        }
//    }
//
//    @objc func submitButtonTapped() {
//        guard let title = titleTextField.text, !title.isEmpty,
//              let description = descriptionTextView.text, !description.isEmpty,
//              let price = priceTextField.text, !price.isEmpty,
//              let address = addressTextField.text, !address.isEmpty,
//              let category = categoryButton.titleLabel?.text, category != "Select a category",
//              let selectedImage = selectedImage else {
//            // Handle missing or invalid data
//            print("Please fill in all fields.")
//            return
//        }
//        
//        // Convert the selected image to Data
//        guard let imageData = selectedImage.jpegData(compressionQuality: 0.75) else {
//            print("Failed to convert image to data")
//            return
//        }
//        
//        // Upload the image data to Firebase Storage
//        uploadImageDataToFirebase(imageData: imageData) { imageUrl in
//            if let imageUrl = imageUrl {
//                // Prepare data to be uploaded to Firestore
//                let postData: [String: Any] = [
//                    "title": title,
//                    "description": description,
//                    "price": price,
//                    "address": address,
//                    "category": category,
//                    "imageUrl": imageUrl,
//                    "timestamp": FieldValue.serverTimestamp() // Timestamp for the post
//                ]
//                
//                // Add the post to Firestore
//                self.db.collection("posts").addDocument(data: postData) { error in
//                    if let error = error {
//                        print("Error adding document: \(error)")
//                    } else {
//                        print("Document added successfully!")
//                        // Optionally navigate away or reset the form
//                    }
//                }
//            } else {
//                print("Image upload failed.")
//            }
//        }
//    }
//
//}
//
//// UITextField padding helper
//extension UITextField {
//    func setLeftPaddingPoints(_ amount: CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//}


import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    let addPostLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    let selectedImageView = UIImageView()
    var selectedImage: UIImage?
    let titleTextField = UITextField()
    let descriptionTextView = UITextView()
    let priceTextField = UITextField()
    let addressTextField = UITextField()
    let categoryButton = UIButton()
    var categories: [Category] = []
    let submitButton = UIButton()
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(addPostLabel)
        configureAddPostLabel()
        setupSelectedImageView()
        displayPlaceholderImage()
        
        setupTitleTextField()
        setupDescriptionTextView()
        setupPriceTextField()
        setupAddressTextField()
        setupCategoryButton()
        setupSubmitButton()
        fetchCategories()
    }

    func configureAddPostLabel() {
        addPostLabel.text = "Add Post"
        addPostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addPostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addPostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    func setupSelectedImageView() {
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.contentMode = .scaleAspectFill
        selectedImageView.clipsToBounds = true
        selectedImageView.layer.cornerRadius = 10
        selectedImageView.layer.borderColor = UIColor.systemGray.cgColor
        selectedImageView.layer.borderWidth = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        selectedImageView.addGestureRecognizer(tapGesture)
        selectedImageView.isUserInteractionEnabled = true
        
        view.addSubview(selectedImageView)

        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: addPostLabel.bottomAnchor, constant: 20),
            selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedImageView.widthAnchor.constraint(equalToConstant: 120),
            selectedImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func displayPlaceholderImage() {
        let placeholderImage = UIImage(systemName: "photo")
        selectedImageView.image = placeholderImage
        selectedImageView.tintColor = .systemGray
    }

    func styleTextField(_ textField: UITextField, placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.setLeftPaddingPoints(10) // Helper to add padding
    }

    func setupTitleTextField() {
        styleTextField(titleTextField, placeholder: "Enter title")
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupDescriptionTextView() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray.cgColor
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.text = "Enter description..."
        descriptionTextView.textColor = .systemGray
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.delegate = self
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setupPriceTextField() {
        styleTextField(priceTextField, placeholder: "Enter price")
        priceTextField.keyboardType = .decimalPad
        view.addSubview(priceTextField)
        
        NSLayoutConstraint.activate([
            priceTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priceTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupAddressTextField() {
        styleTextField(addressTextField, placeholder: "Enter address")
        view.addSubview(addressTextField)
        
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 15),
            addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addressTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupCategoryButton() {
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setTitle("Select a category", for: .normal)
        categoryButton.setTitleColor(.systemBlue, for: .normal)
        categoryButton.backgroundColor = .systemGray6
        categoryButton.layer.cornerRadius = 8
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.systemGray.cgColor
        categoryButton.addTarget(self, action: #selector(showCategoryMenu), for: .touchUpInside)
        view.addSubview(categoryButton)
        
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 15),
            categoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func showCategoryMenu() {
        let menuItems = categories.map { category in
            UIAction(title: category.name, handler: { [weak self] _ in
                self?.categoryButton.setTitle(category.name, for: .normal)
            })
        }

        let menu = UIMenu(title: "", options: .displayInline, children: menuItems)
        categoryButton.menu = menu
        categoryButton.showsMenuAsPrimaryAction = true
    }
    
    func setupSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func pickImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            selectedImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func fetchCategories() {
        CategoryService.shared.fetchCategories { [weak self] categories in
            self?.categories = categories
        }
    }
    
    func uploadImageDataToFirebase(imageData: Data, completion: @escaping (String?) -> Void) {
        // Create a reference to Firebase Storage
        let storageRef = Storage.storage().reference().child("postImages/\(UUID().uuidString).jpg")
        
        // Upload the image data
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Get the image URL after upload
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting image URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                completion(url?.absoluteString)
            }
        }
    }
    
    @objc func submitButtonTapped() {
        // Ensure all fields are filled
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let price = priceTextField.text, !price.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let category = categoryButton.titleLabel?.text, category != "Select a category" else {
            // Handle missing or invalid data
            print("Please fill in all fields.")
            return
        }
        
        // Get the current timestamp as Unix time (seconds since 1970)
        let timestamp = Date().timeIntervalSince1970
        
        // Prepare the data to be uploaded to Firestore
        let postData: [String: Any] = [
            "title": title,
            "description": description,
            "price": price,
            "address": address,
            "category": category,
            "timestamp": timestamp,  // Store Unix timestamp
        ]
        
        // Add the post to Firestore
        db.collection("posts").addDocument(data: postData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
                // Optionally navigate away or reset the form
            }
        }
    }

    }


// UITextField padding helper
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
