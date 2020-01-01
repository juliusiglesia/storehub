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
    
    @Published var productCatalog: Array<ProductCatalog>!
    
    internal var subscriptions: Array<AnyCancellable>!
    
    init() {
        self.managers = DataManagers(
            category: CategoryDataManager(),
            price: PriceDataManager(),
            product: ProductDataManager()
        )
        
        self.refresh()
        
        self.subscriptions = [
            self.managers.category.$data.sink { _ in self.asyncRefresh() },
            self.managers.price.$data.sink { _ in self.asyncRefresh() },
            self.managers.product.$data.sink { _ in self.asyncRefresh() }
        ]
    }
    
    internal func asyncRefresh() {
        DispatchQueue.main.async {
            self.refresh()
        }
    }
    
    internal func refresh() {
        self.productCatalog = self.managers.product.data.map {
            let price = self.managers.price.getByProduct(product: $0)
            return ProductCatalog(product: $0, price: price)
        }
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
    
    init(category: CategoryDataManager, price: PriceDataManager, product: ProductDataManager) {
        self.category = category
        self.price = price
        self.product = product
    }
}

class ProductCatalog: Hashable, Identifiable {
    var product: Product
    var price: Price?
    
    init(product: Product, price: Price?) {
        self.product = product
        self.price = price
    }
    
    static func == (lhs: ProductCatalog, rhs: ProductCatalog) -> Bool {
        return lhs.product == rhs.product
    }
    
    func hash(into hasher: inout Hasher) {
        product.hash(into: &hasher)
    }
}
