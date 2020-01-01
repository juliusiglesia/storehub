//
//  Formatter.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation

class Formatter {
    private static var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencySymbol = ""
        return f
    }()
    
    private static var decimalFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.usesGroupingSeparator = true
        f.groupingSize = 3
        f.secondaryGroupingSize = 2
        return f
    }()
    
    
    static func toMoneyString(num: Double) -> String {
        return self.currencyFormatter.string(from: NSNumber(value: num)) ?? ""
    }
    
    static func toDecimalString(num: Double) -> String {
        return self.decimalFormatter.string(from: NSNumber(value: num)) ?? ""
    }
}
