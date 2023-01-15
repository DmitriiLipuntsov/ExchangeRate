//
//  String+Ex.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 14.01.2023.
//

import Foundation

extension String {
    var to2fString: String {
        return String(format: "%.2f", self)
    }
}
