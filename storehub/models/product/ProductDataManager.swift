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
    
    @Published var products: Array<Product> = []
    
    init() {
        refresh()
    }
    
    func refresh() {
        do {
            self.products = try context.fetch(Product.getAllProductsRequest())
        } catch {
            print("Error fetching products, \(error)")
        }
    }
    
    func add(name: String, category: Category?) {
        let product = Product(context: context)
        product.id = UUID().uuidString
        product.name = name
        product.category = category
        
        do {
            try context.save()
            refresh()
        } catch {
            print("Error saving product, \(String(describing: category))")
        }
    }
}
