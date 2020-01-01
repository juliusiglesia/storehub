//
//  Category.swift
//  storehub
//
//  Created by Julius Iglesia on 29/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation
import CoreData

public class Category: Record {
    @NSManaged public var label: String?
    
    public var wrappedLabel: String {
        label ?? "Unknown Category"
    }
}

extension Category {
    static func getAllCategoriesRequest() -> NSFetchRequest<Category> {
        let request = Category.fetchRequest() as! NSFetchRequest<Category>
        request.sortDescriptors = []
        return request
    }
}
