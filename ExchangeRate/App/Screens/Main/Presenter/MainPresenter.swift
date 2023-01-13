//
//  MainPresenter.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 11.01.2023.
//

import Foundation
import Combine

class MainPresenter: MainPresenterProtocol {
    
    var dateCollection: [Date] = []
    var currencies: [CurrencyModel] = []
    
    var currentDateText: String {
        let date = dateCollection[selectedDateIndex]
        return formatDate(date: date)
    }
    
    private let networkService: MainNetworkService
    private let coordinator: CoordinatorProtocol
    private let view: MainViewProtocol
    
    private var selectedDateIndex: Int = 0
    private var selectedDate: Date = Date()
    private let dateFormatter = DateFormatter()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: MainNetworkService, coordinator: CoordinatorProtocol, view: MainViewProtocol) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.view = view
        
        currenciesSink()
        buildDateCollection()
        selectedDateIndex = setSelectedDate()
    }
    
    func setSelectedDate() -> Int {
        var row = 0
        for index in dateCollection.indices{
            let today = Date()
            if Calendar.current.compare(today, to: dateCollection[index], toGranularity: .day) == .orderedSame{
                row = index
            }
        }
        return row
    }
    
    func datePickerSelect(row: Int) {
        selectedDate = dateCollection[row]
    }
    
    func saveButtonPressed() {
        view.dateChanged(to: formatDate(date: selectedDate))
        currenciesSink()
    }
    
    func closeButtonPressed() {
        view.dateChanged(to: formatDate(date: Date()))
    }
    
    func tapOnTheCell(index: Int) {
        let selectedCurrency = currencies[index]
        coordinator.showConvertorVC(with: selectedCurrency)
    }
    
    private func buildDateCollection() {
        dateCollection.append(contentsOf: Date.previousYear())
    }
    
    private func formatDate(date: Date) -> String {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }

    private func currenciesSink() {
        networkService.getCurrencies(date: selectedDate).sink { competion in
            switch competion {
            case .finished:
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.failure(error: error)
                }
            }
        } receiveValue: { [weak self] currencies in
            self?.currencies = currencies
            DispatchQueue.main.async {
                self?.view.succes()
            }
        }
        .store(in: &cancellables)

    }
}
