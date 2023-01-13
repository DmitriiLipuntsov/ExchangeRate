//
//  NetworkManager.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 11.01.2023.
//

import Foundation
import Combine

protocol NetworkManagerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func get<T>(
        type: T.Type,
        url: URL,
        headers: Headers
    ) -> AnyPublisher<T, Error> where T: Decodable
    
}

class NetworkManager: NetworkManagerProtocol {
    
    func get<T: Decodable>(
        type: T.Type,
        url: URL,
        headers: Headers
    ) -> AnyPublisher<T, Error> {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

protocol CurrenciesLogicControllerProtocol: AnyObject {
    var networkController: NetworkManagerProtocol { get }

    func getCurrencies(date: String) -> AnyPublisher<CurranciesEntity, Error>
}
