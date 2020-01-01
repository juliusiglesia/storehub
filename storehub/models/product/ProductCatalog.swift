//
//  ProductCatalog.swift
//  storehub
//
//  Created by Julius Iglesia on 01/01/2020.
//  Copyright © 2020 Julius Iglesia. All rights reserved.
//

import Foundation
import CoreData

public class ProductCatalog: Record {
    @NSManaged public var count: Int
    @NSManaged public var product: Product?
    @NSManaged public var price: Price?
}

extension ProductCatalog {
    static func getAllProductCatalogRequest() -> NSFetchRequest<ProductCatalog> {
        let request = ProductCatalog.fetchRequest() as! NSFetchRequest<ProductCatalog>
        request.sortDescriptors = []
        return request
    }
}
