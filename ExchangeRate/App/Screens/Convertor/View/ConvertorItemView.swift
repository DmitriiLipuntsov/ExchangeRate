//
//  ConvertorItemView.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 14.01.2023.
//

import UIKit

class ConvertorItemView: UIView {
    
    private let currencyTextField = UITextField()
    private let currencyCodeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currencyTextField.addUnderLine()
    }
    
    func configure(currencyCode: String) {
        currencyCodeLabel.text = currencyCode
        
        var selector: Selector
        if currencyCode == "RUB" {
            selector = #selector(ConvertorViewController.rubTextFieldDidChange(_: ))
        } else {
            selector = #selector(ConvertorViewController.textFieldDidChange(_: ))
        }
        currencyTextField.addTarget(
            nil,
            action: selector,
            for: .editingChanged
        )
    }
    
    func setNewValue(value: String) {
            currencyTextField.text = value
    }
    
    private func setupUI() {
        setupCurrencyCodeLabel()
        setupCurrencyTextField()

        setConstraints()
    }
    
    private func setupCurrencyCodeLabel() {
        currencyCodeLabel.backgroundColor = .white
        currencyCodeLabel.text = ""
        currencyCodeLabel.textColor = .convertorRateLableText
        currencyCodeLabel.font = UIFont(name: AppFonts.sfProTextMedium, size: 14)
        currencyCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(currencyCodeLabel)
    }
    
    private func setupCurrencyTextField() {
        currencyTextField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.convertorTextFieldTint]
        )
        currencyTextField.keyboardType = .decimalPad
        currencyTextField.font = UIFont(name: AppFonts.sfProTextMedium, size: 36)
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currencyTextField)
    }
    
}

//MARK: - Setup contstraints
extension ConvertorItemView {
    private func setConstraints() {
        // currencyCodeLabel
        NSLayoutConstraint.activate([
            currencyCodeLabel.topAnchor.constraint(
                equalTo: topAnchor
            ),
            currencyCodeLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            currencyCodeLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])

        // currencyTextField
        NSLayoutConstraint.activate([
            currencyTextField.topAnchor.constraint(
                equalTo: currencyCodeLabel.bottomAnchor,
                constant: 8),
            currencyTextField.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            currencyTextField.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])
    }
}
