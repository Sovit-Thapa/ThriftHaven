//
//  AddPostVC.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let addPostLabel = THTitleLabel(textAlignment: .left, fontSize: 28)
    let selectedImageView = UIImageView()
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(addPostLabel)
        configureAddPostLabel()
        setupSelectedImageView()
        displayPlaceholderImage()
    }
    
    func configureAddPostLabel() {
        addPostLabel.text = "Add Post"
        
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}




