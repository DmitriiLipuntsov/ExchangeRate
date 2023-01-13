//
//  Coordinator.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 11.01.2023.
//

import UIKit

struct Item {
    
}

protocol CoordinatorProtocol {
    func createMainVC() -> UIViewController
    func showConvertorVC(with item: CurrencyModel)
}

final class Coordinator: CoordinatorProtocol {
    var currentNavigationController: UINavigationController?
    private let networkManager = NetworkManager()
    
    init() {
        let vc = createMainVC()
        currentNavigationController = UINavigationController(rootViewController: vc)
    }
    
    func createMainVC() -> UIViewController {
        let vc = MainViewController()
        let networkService = MainNetworkService(networkManager: networkManager)
        let presentor = MainPresenter(networkService: networkService, coordinator: self, view: vc)
        vc.presenter = presentor
        
        return vc
    }
    
    func showConvertorVC(with item: CurrencyModel) {
        let vc = ConvertorViewController(navTitle: item.title)
        let presentor = ConvertorPresenter(coordinator: self, view: vc)
        currentNavigationController?.pushViewController(vc, animated: true)
        vc.presentor = presentor
    }
    
}
