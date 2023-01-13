//
//  MainNetworkService.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import Foundation
import Combine

class MainNetworkService {
    @Published var currencies: [CurrencyModel]? = nil
    
    private let dateFormatter: DateFormatter =  {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        return df
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getData(date: Date())
    }
    
    func getData(date: Date) {
        let stringDate = dateFormatter.string(from: date)
        guard let url = URL(string: Endpoints.getArchiveDataEndpoint(date: stringDate)) else {
            fatalError("Invalid string url store")
        }
        
        NetworkManager.download(url: url)
            .decode(type: CurranciesEntity.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.currencies = response.valute.values.map { entity -> CurrencyModel in
                        return self.transformResponseCurrencyEntityToModel(entity: entity)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    private func transformResponseCurrencyEntityToModel(entity: CurrancyEntity) -> CurrencyModel {
        return CurrencyModel(id: entity.id, title: entity.charCode, value: entity.value)
    }
}
