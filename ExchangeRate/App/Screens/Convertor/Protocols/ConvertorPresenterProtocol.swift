//
//  ConvertorPresenterProtocol.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import Foundation

protocol ConvertorPresenterProtocol {
    var currancyData: CurrencyModel { get }
    
    func rubChanged(value: String)
    func currencyChanged(value: String)
}
