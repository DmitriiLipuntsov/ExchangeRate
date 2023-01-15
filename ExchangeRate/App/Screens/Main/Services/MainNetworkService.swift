//
//  MainNetworkService.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import Foundation
import Combine

class MainNetworkService {
    let networkManager: NetworkManagerProtocol
    
    private let cache = Cache<String, [CurrencyModel]>()
    private let dateFormatter: DateFormatter =  {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        return df
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCurrencies(date: Date) -> AnyPublisher<[CurrencyModel], Error> {
        let stringDate = dateFormatter.string(from: date)
        let endpoint = Endpoint.currencies(date: stringDate)
        
        if let cachedResponse = cache[stringDate] {
            return Just(cachedResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return networkManager.get(
            type: CurranciesEntity.self,
            url: endpoint.url,
            headers: [:])
            .map { [weak self] response -> [CurrencyModel] in
                var currencyModels: [CurrencyModel] = []
                let responce = response.valute.values.map { entity -> CurrencyModel in
                    let currencyModel = CurrencyModel(
                        id: entity.id,
                        title: entity.charCode,
                        name: entity.name,
                        value: entity.value
                    )
                    currencyModels.append(currencyModel)
                    return currencyModel
                }
                self?.cache[stringDate] = currencyModels
                return responce
            }
            .eraseToAnyPublisher()
    }
}
