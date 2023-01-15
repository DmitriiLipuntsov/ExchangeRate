//
//  ConvertorInfoView.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import UIKit

class ConvertorInfoView: UIView {
    
    private let titleLabel = UILabel()
    private let rateLabel = UILabel()
    private let exchangeRateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cellBackground

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, value: Double) {
        titleLabel.text = title
        exchangeRateLabel.text = value.to2fString + " ₽"
    }
    
    private func setupUI() {
        setupTitleLabel()
        setupRateLabel()
        setupExchangeRateLabel()
        
        setConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: AppFonts.robotoMedium, size: 18)
        titleLabel.text = ""
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
    }
    
    private func setupRateLabel() {
        rateLabel.textColor = .black
        rateLabel.font = UIFont(name: AppFonts.robotoMedium, size: 18)
        rateLabel.text = "Курс"
        rateLabel.alpha = 0.6
        rateLabel.textColor = .convertorRateLableText
        rateLabel.font = UIFont(name: AppFonts.sfProDisplayRegular, size: 15.32)
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(rateLabel)
    }
    
    private func setupExchangeRateLabel() {
        exchangeRateLabel.textColor = .black
        exchangeRateLabel.font = UIFont(name: AppFonts.robotoMedium, size: 18)
        exchangeRateLabel.text = "59.22 ₽"
        exchangeRateLabel.font = UIFont(name: AppFonts.sfProTextSemibold, size: 26)
        exchangeRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(exchangeRateLabel)
    }
}

//MARK: - Setup contstraints
extension ConvertorInfoView {
    private func setConstraints() {
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            )
        ])
        
        // convertorInfoView
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 15),
            rateLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            rateLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            )
        ])
        
        // convertorInfoView
        NSLayoutConstraint.activate([
            exchangeRateLabel.topAnchor.constraint(
                equalTo: rateLabel.bottomAnchor,
                constant: 6),
            exchangeRateLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            exchangeRateLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            )
        ])
    }
}
