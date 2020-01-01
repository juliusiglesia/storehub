//
//  ProductCatalogDataManager.swift
//  storehub
//
//  Created by Julius Iglesia on 01/01/2020.
//  Copyright © 2020 Julius Iglesia. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class ProductCatalogDataManager: ObservableObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Published var data: Array<ProductCatalog>!
    
    init() {
        refresh()
    }
    
    func refresh() {
        do {
            self.data = try context.fetch(ProductCatalog.getAllProductCatalogRequest())
        } catch {
            print("Error fetching product catalog, \(error)")
        }
    }
    
    func add(count: Int, product: Product, price: Price) throws -> ProductCatalog {
        let catalog = ProductCatalog(context: context)
        catalog.count = count
        catalog.product = product
        catalog.price = price
        catalog.setCreateTimestamp()
        
        try? context.save()
        refresh()
        return catalog
    }
}
