//
//  StoreHubDataManager.swift
//  storehub
//
//  Created by Julius Iglesia on 01/01/2020.
//  Copyright © 2020 Julius Iglesia. All rights reserved.
//

import Foundation
import Combine

class StoreHubDataManager: ObservableObject {
    var managers: DataManagers
    
    internal var subscriptions: Array<AnyCancellable>!
    
    init() {
        self.managers = DataManagers(
            category: CategoryDataManager(),
            price: PriceDataManager(),
            product: ProductDataManager(),
            productCatalog: ProductCatalogDataManager()
        )
        
        self.refresh()
        
        self.subscriptions = [
            self.managers.category.$data.sink { _ in self.asyncRefresh() },
            self.managers.price.$data.sink { _ in self.asyncRefresh() },
            self.managers.product.$data.sink { _ in self.asyncRefresh() }
        ]
    }
    
    public func addProduct(name: String, category: Category?, noOfStocks: Int, costPrice: Double, sellPrice: Double) {
        do {
            let product = try? self.managers.product.save(name: name, category: category)
            let price = try? self.managers.price.save(product: product!, cost: costPrice, sell: sellPrice)
            let _ = try? self.managers.productCatalog.add(count: noOfStocks, product: product!, price: price!)
        } catch {
            print("Error saving all product entities")
        }
    }
    
    internal func asyncRefresh() {
        DispatchQueue.main.async {
            self.refresh()
        }
    }
    
    internal func refresh() {
        
    }
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
    }
}

class DataManagers {
    var category: CategoryDataManager
    var price: PriceDataManager
    var product: ProductDataManager
    var productCatalog: ProductCatalogDataManager
    
    init(category: CategoryDataManager, price: PriceDataManager, product: ProductDataManager, productCatalog: ProductCatalogDataManager) {
        self.category = category
        self.price = price
        self.product = product
        self.productCatalog = productCatalog
    }
}

