//
//  Double.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation

extension Double {
    var money: String {
        Formatter.toMoneyString(num: self)
    }
    
    var string: String {
        Formatter.toDecimalString(num: self)
    }
}
