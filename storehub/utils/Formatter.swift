//
//  Formatter.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation

class Formatter {
    private static var formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.usesGroupingSeparator = true
        f.groupingSize = 3
        f.secondaryGroupingSize = 2
        return f
    }()
    
    static func toString(num: Double) -> String {
        return self.formatter.string(from: NSNumber(value: num)) ?? ""
    }
}
