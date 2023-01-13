//
//  Currencies.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import Foundation

struct CurranciesEntity: Codable, CustomStringConvertible {
    let date, previousDate: String
    let previousURL: String
    let timestamp: String
    let valute: [String: CurrancyEntity]

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}

// MARK: - Valute
struct CurrancyEntity: Codable, CustomStringConvertible {
    let id, numCode, charCode: String
    let nominal: Int
    let name: String
    let value, previous: Double

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}
