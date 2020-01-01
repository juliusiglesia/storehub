//
//  FilteredValue.swift
//  storehub
//
//  Created by Julius Iglesia on 30/12/2019.
//  Copyright © 2019 Julius Iglesia. All rights reserved.
//

import Foundation
import Combine

public class FilteredValue: ObservableObject {
    @Published var value = ""
    
    internal var cancellable: AnyCancellable!
    internal var charset: CharacterSet
    
    init(charset: CharacterSet) {
        self.charset = charset
        cancellable = $value.sink { val in self.process(newVal: val) }
    }
    
    func process(newVal: String) {
        if newVal.rangeOfCharacter(from: self.charset.inverted) != nil {
            DispatchQueue.main.async {
                self.value = String(self.value.unicodeScalars.filter {
                    self.charset.contains($0)
                })
            }
        }
    }

    deinit {
        cancellable.cancel()
    }
}

public class NumericValue: FilteredValue {
    var number: Int {
        Int(value) ?? 0
    }

    init() {
        super.init(charset: CharacterSet(charactersIn: "1234567890"))
    }
}

public class DecimalValue: FilteredValue {
    var number: Double {
        Double(value) ?? 0
    }
    
    init() {
        super.init(charset: CharacterSet(charactersIn: "1234567890."))
    }
    
    override func process(newVal: String) {
        if newVal.rangeOfCharacter(from: self.charset.inverted) != nil || countDecimals(val: newVal) > 1 {
            DispatchQueue.main.async {
                var hasDecimal = false
                self.value = String(self.value.unicodeScalars.filter {
                    if $0 == "." {
                        if hasDecimal {
                            return false
                        } else {
                            hasDecimal = true
                            return true
                        }
                    } else {
                        return self.charset.contains($0)
                    }
                })
            }
        }
    }
    
    private func countDecimals(val: String) -> Int {
        var count = 0
        val.unicodeScalars.forEach {
            if $0 == "." {
                count = count + 1
            }
        }
        
        return count
    }
}

