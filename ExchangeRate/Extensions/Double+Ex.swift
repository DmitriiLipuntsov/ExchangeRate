//
//  Double+Ex.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 14.01.2023.
//

import Foundation

extension Double {
    
    var to2fString: String {
        var roundedDouble = Int(self * 100)
        roundedDouble = roundedDouble / 100
        let stringFromNumber = String(self)
        
        if let dotIndex = stringFromNumber.range(of: ".")?.upperBound {
            let charactersCount = stringFromNumber.count
            let distancToDot = stringFromNumber.distance(from: stringFromNumber.startIndex, to: dotIndex)
            if charactersCount > (distancToDot + 1) {
                let endIndex = stringFromNumber.index(dotIndex, offsetBy:2)
                return String(stringFromNumber[..<endIndex])
            } else if charactersCount > distancToDot {
                let endIndex = stringFromNumber.index(dotIndex, offsetBy:1)
                return String(stringFromNumber[..<endIndex])
            } else {
                return stringFromNumber
            }
        } else {
            return stringFromNumber
        }
    }
    
}
