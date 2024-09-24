//
//  THButton.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-22.
//

import UIKit

class THButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String){
        self.init(frame: .zero)
        set(color: backgroundColor, title: title)
    }
    
    private func configure(){
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func set(color: UIColor, title: String){
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        
        configuration?.title = title
    }
}
