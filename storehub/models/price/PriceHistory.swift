//
//  PriceHistory.swift
//  storehub
//
//  Created by Julius Iglesia on 01/01/2020.
//  Copyright © 2020 Julius Iglesia. All rights reserved.
//

import Foundation
import CoreData

public class PriceHistory: Record {
    @NSManaged public var cost: Double
    @NSManaged public var sell: Double
    @NSManaged public var product: Product?
}

extension PriceHistory {
    static func getAllPriceHistoryRequest() -> NSFetchRequest<PriceHistory> {
        let request = PriceHistory.fetchRequest() as! NSFetchRequest<PriceHistory>
        request.sortDescriptors = []
        return request
    }
}
