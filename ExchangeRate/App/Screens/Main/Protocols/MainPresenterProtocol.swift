//
//  MainPresenterProtocol.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import Foundation

protocol MainPresenterProtocol {
    var dateCollection: [Date] { get }
    var currentDateText: String { get }
    var currencies: [CurrencyModel] { get }
    
    func setSelectedDate() -> Int
    func datePickerSelect(row: Int)
    func saveButtonPressed()
    func closeButtonPressed()
    func tapOnTheCell(index: Int)
}
