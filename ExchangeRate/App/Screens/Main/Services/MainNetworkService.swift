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
        
        return networkManager.get(
            type: CurranciesEntity.self,
            url: endpoint.url,
            headers: [:])
            .map { response -> [CurrencyModel] in
                return response.valute.values.map { entity -> CurrencyModel in
                    return CurrencyModel(
                        id: entity.id,
                        title: entity.charCode,
                        value: entity.value
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func transformResponseCurrencyEntityToModel(entity: CurrancyEntity) -> CurrencyModel {
        return CurrencyModel(id: entity.id, title: entity.charCode, value: entity.value)
    }
}
