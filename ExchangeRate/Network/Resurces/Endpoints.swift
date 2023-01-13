//
//  Endpoints.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import Foundation

struct Endpoint {
    var path: String
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.cbr-xml-daily.ru"
        components.path = "/archive/\(path)/daily_json.js"
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static func currencies(date: String) -> Self {
        return Endpoint(path: date)
    }
}

