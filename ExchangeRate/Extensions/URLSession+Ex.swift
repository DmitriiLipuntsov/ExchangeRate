//
//  URLSession+Ex.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 15.01.2023.
//

import Foundation
import Combine

typealias ShortOutput = URLSession.DataTaskPublisher.Output

extension URLSession {
    // 2
    func dataTaskPublisher(for url: URL,
                           cachedResponseOnError: Bool) -> AnyPublisher<ShortOutput, Error> {

        return self.dataTaskPublisher(for: url)
            // 3
            .tryCatch { [weak self] (error) -> AnyPublisher<ShortOutput, Never> in
                // 4
                guard cachedResponseOnError,
                    let urlCache = self?.configuration.urlCache,
                    let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url))
                else {
                    throw error
                }

                // 5
                return Just(ShortOutput(
                    data: cachedResponse.data,
                    response: cachedResponse.response
                )).eraseToAnyPublisher()
        // 6
        }.eraseToAnyPublisher()
    }
}
