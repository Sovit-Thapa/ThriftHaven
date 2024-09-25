//
//  Category.swift
//  ThriftHaven
//
//  Created by Sovit Thapa on 2024-09-25.
//

import UIKit
import Firebase

class Category {
    var icon: URL
    var name: String
    
    init(icon: URL, name: String) {
        self.icon = icon
        self.name = name
    }
}

class CategoryService {
    
    static let shared = CategoryService()
    var categories: [Category] = []

    private init() {}

    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        let firestoreDB = Firestore.firestore()
        
        firestoreDB.collection("Category").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching categories: \(error)")
                completion([])
                return
            }
            
            self.categories = []
            
            for document in snapshot!.documents {
                let data = document.data()
                if let iconString = data["icon"] as? String,
                   let iconURL = URL(string: iconString),
                   let name = data["name"] as? String {
                    let category = Category(icon: iconURL, name: name)
                    self.categories.append(category)
                }
            }
            
            DispatchQueue.main.async {
                completion(self.categories)
            }
        }
    }
}
