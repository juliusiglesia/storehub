//
//  Double.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation

extension Double {
    var decimalString: String {
        Formatter.toString(num: self)
    }
}
