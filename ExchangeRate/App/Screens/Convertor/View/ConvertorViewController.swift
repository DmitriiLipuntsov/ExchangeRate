//
//  ConvertorViewController.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import UIKit

class ConvertorViewController: UIViewController {
    
    private let navTitle: String
    private var presentor: ConvertorPresenterProtocol!
    
    init(navTitle: String) {
        self.navTitle = navTitle
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = navTitle
        
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
}

extension ConvertorViewController: ConvertorViewProtocol {
    
}
