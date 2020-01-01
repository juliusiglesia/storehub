//
//  Array.swift
//  storehub
//
//  Created by Julius Iglesia on 31/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation

extension Array {
    var isAnyEmpty: Bool {
        return self.contains(where: {
            if let str = $0 as? String {
                return str.isEmpty
            }
            
            return $0 != nil
        })
    }
}
