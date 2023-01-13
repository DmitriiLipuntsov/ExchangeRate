//
//  CurrancyCell.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import UIKit

class CurrancyCell: UICollectionViewCell {
    static let identifier = "CurrancyCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .customBlue
        label.textAlignment = .center
        label.font = UIFont(name: AppFonts.sfProDisplayBold, size: 30)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .cellValue
        label.textAlignment = .center
        label.font = UIFont(name: AppFonts.sfProDisplayRegular, size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cellBackground
        layer.cornerRadius = 12
        clipsToBounds = true
        addSubview(titleLabel)
        addSubview(valueLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: CurrencyModel) {
        titleLabel.text = model.title
        valueLabel.text = String(format: "%.2f", model.value) +  " ₽"
    }
    
    private func setConstraints() {
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 21),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor),
        ])
        
        // valueLabel
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 5),
            valueLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            valueLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor),
        ])
        
    }
}
