//
//  CategoryCell.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    let iconImageView = THImageView(frame: .zero)
    let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Category) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: category.icon),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.iconImageView.image = UIImage(named: "defaultIcon")
                }
            }
        }
        nameLabel.text = category.name
    }
}




