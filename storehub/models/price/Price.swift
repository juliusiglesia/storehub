//
//  Price.swift
//  storehub
//
//  Created by Julius Iglesia on 01/01/2020.
//  Copyright © 2020 Julius Iglesia. All rights reserved.
//

import Foundation
import CoreData

public class Price: Record {
    @NSManaged public var cost: Double
    @NSManaged public var sell: Double
    @NSManaged public var product: Product?
}

extension Price {
    static func getAllPricesRequest() -> NSFetchRequest<Price> {
        let request = Price.fetchRequest() as! NSFetchRequest<Price>
        request.sortDescriptors = []
        return request
    }
}
