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
    func showDetail(with item: Item)
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
        let presentor = MainPresenter(networkManager: networkManager, coordinator: self, view: vc)
        vc.presenter = presentor
        
        return vc
    }
    
    func showDetail(with item: Item) {
//        let vc = DetailViewController()
//        vc.configure(with: item)
//        currentNavigationController?.pushViewController(vc, animated: true)
    }
    
}
