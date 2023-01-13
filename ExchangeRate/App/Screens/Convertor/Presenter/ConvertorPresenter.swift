//
//  ConvertorPresenter.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import Foundation

class ConvertorPresenter: ConvertorPresenterProtocol {
    
    private let coordinator: CoordinatorProtocol
    private let view: ConvertorViewProtocol
    
    init(coordinator: CoordinatorProtocol, view: ConvertorViewProtocol) {
        self.coordinator = coordinator
        self.view = view
    }
}
