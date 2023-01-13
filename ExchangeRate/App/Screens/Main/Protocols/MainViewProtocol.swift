//
//  MainViewProtocol.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import Foundation

protocol MainViewProtocol {
    func dateChanged(to stringDate: String)
    func succes()
    func failure(error: Error)
}
