//
//  PriceDataManager.swift
//  storehub
//
//  Created by Julius Iglesia on 01/01/2020.
//  Copyright © 2020 Julius Iglesia. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class PriceDataManager: ObservableObject {
    @EnvironmentObject var productDataManager: ProductDataManager
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Published var data: Array<Price> = []
    
    init() {
        refresh()
    }
    
    func refresh() {
        do {
            self.data = try context.fetch(Price.getAllPricesRequest())
        } catch {
            print("Error fetching prices, \(error)")
        }
    }
    
    func save(product: Product, cost: Double, sell: Double) throws -> Price {
        var price = getByProduct(product: product)
        if price != nil {
            price!.cost = cost
            price!.sell = sell
            price!.setUpdateTimestamp()
        } else {
            price = Price(context: context)
            price!.product = product
            price!.cost = cost
            price!.sell = sell
            price!.setCreateTimestamp()
        }
        
        try? context.save()
        refresh()
        return price!
    }
    
    func getByProduct(product: Product) -> Price? {
        return self.data.filter {
            $0.product?.id == product.id
        }.first
    }
}
