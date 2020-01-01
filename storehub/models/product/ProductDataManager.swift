//
//  ProductDataManager.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class ProductDataManager: ObservableObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Published var data: Array<Product> = []
    
    init() {
        refresh()
    }
    
    func refresh() {
        do {
            self.data = try context.fetch(Product.getAllProductsRequest())
        } catch {
            print("Error fetching products, \(error)")
        }
    }
    
    func add(name: String, category: Category?) throws -> Product {
        let product = Product(context: context)
        product.name = name
        product.category = category
        product.setCreateTimestamp()
        
        try? context.save()
        refresh()
        return product
    }
    
    func get(id: String) -> Product? {
        return self.data.filter {
            $0.wrappedId == id
        }.first
    }
}
