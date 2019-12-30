//
//  Product.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation
import CoreData

public class Product: NSManagedObject, Identifiable {
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var category: Category?
    
    public var wrappedId: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Product"
    }
}

extension Product {
    static func getAllProductsRequest() -> NSFetchRequest<Product> {
        let request = Product.fetchRequest() as! NSFetchRequest<Product>
        request.sortDescriptors = []
        return request
    }
}
