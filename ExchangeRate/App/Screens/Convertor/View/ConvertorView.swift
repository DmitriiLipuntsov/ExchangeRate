//
//  ConvertorView.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import UIKit

class ConvertorView: UIView {
    
    private let firstConvertorItemView = ConvertorItemView()
    private let rubConvertorItemView = ConvertorItemView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 17)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(currencyCode: String) {
        firstConvertorItemView.configure(currencyCode: currencyCode)
        rubConvertorItemView.configure(currencyCode: "RUB")
    }
    
    func setNewValues(model: ExchangeRateModel) {
        firstConvertorItemView.setNewValue(value: model.currancy)
        rubConvertorItemView.setNewValue(value: model.rubCurrancy)
    }
    
    private func setupUI() {
        setupConvertorItemView()
        setupRubConvertorItemView()

        setConstraints()
    }
    
    private func setupConvertorItemView() {
        firstConvertorItemView.backgroundColor = .white
        firstConvertorItemView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(firstConvertorItemView)
    }
    
    private func setupRubConvertorItemView() {
        rubConvertorItemView.backgroundColor = .white
        rubConvertorItemView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(rubConvertorItemView)
    }
}

//MARK: - Setup contstraints
extension ConvertorView {
    private func setConstraints() {
        // firstConvertorItemView
        NSLayoutConstraint.activate([
            firstConvertorItemView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24),
            firstConvertorItemView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            firstConvertorItemView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            firstConvertorItemView.heightAnchor.constraint(
                equalToConstant: 75
            ),
        ])

        // rubConvertorItemView
        NSLayoutConstraint.activate([
            rubConvertorItemView.topAnchor.constraint(
                equalTo: firstConvertorItemView.bottomAnchor,
                constant: 20),
            rubConvertorItemView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            rubConvertorItemView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            rubConvertorItemView.heightAnchor.constraint(
                equalToConstant: 75
            ),
        ])
    }
}
