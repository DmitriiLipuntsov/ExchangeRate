//
//  ConvertorPresenter.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import Foundation

class ConvertorPresenter: ConvertorPresenterProtocol {
    
    let currancyData: CurrencyModel
    private var exchangeRateModel = ExchangeRateModel(currancy: "0", rubCurrancy: "0")
    
    private let coordinator: CoordinatorProtocol
    private let view: ConvertorViewProtocol
    
    init(coordinator: CoordinatorProtocol, view: ConvertorViewProtocol, currancyModel: CurrencyModel) {
        self.coordinator = coordinator
        self.view = view
        self.currancyData = currancyModel
    }
    
    func rubChanged(value: String) {
        exchangeRateModel.rubCurrancy = value
        let currancy = calculateCurrancy(value: value)
        exchangeRateModel.currancy = currancy
        view.setNewValues(model: exchangeRateModel)
    }
    
    func currencyChanged(value: String) {
        exchangeRateModel.currancy = value
        let rubCurrency = calculateRub(value: value)
        exchangeRateModel.rubCurrancy = rubCurrency
        view.setNewValues(model: exchangeRateModel)
    }
    
    private func calculateCurrancy(value: String) -> String {
        guard let value = Double(value) else {
            return ""
        }
        
        let currency = currancyData.value * value
        return currency.to2fString
    }
    
    private func calculateRub(value: String) -> String {
        guard let value = Double(value) else {
            return ""
        }
        
        let rub = value / currancyData.value
        return rub.to2fString
    }
}
