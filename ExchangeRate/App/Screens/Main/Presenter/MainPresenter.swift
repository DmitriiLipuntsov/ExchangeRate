//
//  MainPresenter.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 11.01.2023.
//

import Foundation
import Combine

protocol MainPresenterProtocol {
    var dateCollection: [Date] { get }
    var currentDateText: String { get }
    var currencies: [CurrencyModel] { get }
    
    func setSelectedDate() -> Int
    func datePickerSelect(row: Int)
    func saveButtonPressed()
    func closeButtonPressed()
}

class MainPresenter: MainPresenterProtocol {
    
    var dateCollection: [Date] = []
    var currencies: [CurrencyModel] = []
    
    var currentDateText: String {
        let date = dateCollection[selectedDateIndex]
        return formatDate(date: date)
    }
    
    private let networkService = MainNetworkService()
    private let networkManager: NetworkManager
    private let coordinator: CoordinatorProtocol
    private let view: MainViewProtocol
    
    private var selectedDateIndex: Int = 0
    private var selectedDate: Date = Date()
    private let dateFormatter = DateFormatter()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManager, coordinator: CoordinatorProtocol, view: MainViewProtocol) {
        self.networkManager = networkManager
        self.coordinator = coordinator
        self.view = view
        
        currenciesSubscribe()
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
        networkService.getData(date: selectedDate)
    }
    
    func closeButtonPressed() {
        view.dateChanged(to: formatDate(date: Date()))
    }
    
    private func buildDateCollection() {
        dateCollection.append(contentsOf: Date.previousYear())
    }
    
    private func formatDate(date: Date) -> String {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }

    private func currenciesSubscribe() {
        networkService.$currencies.sink { completion in
            switch completion {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [weak self] currencies in
            guard let currencies = currencies else { return }
            self?.currencies = currencies
            self?.view.succes()
        }
        .store(in: &cancellables)

    }
}
