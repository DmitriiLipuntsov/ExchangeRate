//
//  Endpoints.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import Foundation

class Endpoints {
    
    private init() {}
    
    static let baseUrl = "https://www.cbr-xml-daily.ru/"
    
    static func getArchiveDataEndpoint(date: String) -> String {
        return baseUrl + "archive/\(date)/daily_json.js"
    }
}


