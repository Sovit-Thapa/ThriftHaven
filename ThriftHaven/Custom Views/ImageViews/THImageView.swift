//
//  THImageView.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class THImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.THLoginImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
