//
//  DatePickerView.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import UIKit

protocol DatePickerViewDelegate {
    func saveButtonPressed()
    func closeButtonPressed()
}

class DatePickerView: UIView {
    
    let datePicker = UIPickerView()
    var delegate: DatePickerViewDelegate?
    
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    private let pickerStack = UIStackView()
    private let separator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pickerBackground
        setupCloseButton()
        setupSaveButton()
        setupPickerStackView()
        
        setConstraints()
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        let font = UIFont(name: AppFonts.sfProDisplayRegular, size: 17)
        saveButton.titleLabel?.font = font
        saveButton.setTitleColor(.customBlue, for: .normal)
        saveButton.backgroundColor = .white
        saveButton.frame.size.height = 118
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func saveButtonAction() {
        delegate?.saveButtonPressed()
    }
    
    private func setupPickerStackSeparator() -> UIView {
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.pickerSeparator
        return separator
    }
    
    private func setupPickerStackView() {
        pickerStack.axis = .vertical
        pickerStack.addArrangedSubview(datePicker)
        pickerStack.addArrangedSubview(setupPickerStackSeparator())
        pickerStack.addArrangedSubview(saveButton)
        pickerStack.backgroundColor = .white
        pickerStack.layer.cornerRadius = 13
        pickerStack.clipsToBounds = true
        
        pickerStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pickerStack)
    }
    
    private func setupCloseButton() {
        closeButton.setTitle("Отмена", for: .normal)
        let font = UIFont(name: AppFonts.sfProTextSemibold, size: 17)
        closeButton.titleLabel?.font = font
        closeButton.setTitleColor(.customBlue, for: .normal)
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 13
        closeButton.clipsToBounds = true
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(closeButton)
    }
    
    @objc private func closeButtonAction() {
        delegate?.closeButtonPressed()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup contstraints
extension DatePickerView {
    private func setConstraints() {
        // CloseButton
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            closeButton.heightAnchor.constraint(
                equalToConstant: 58
            ),
            closeButton.bottomAnchor.constraint(
                equalTo: layoutMarginsGuide.bottomAnchor,
                constant: -16
            ),
        ])
        
        // SaveButton
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(
                equalToConstant: 58
            )
        ])
        
        // PickerStackView
        NSLayoutConstraint.activate([
            pickerStack.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            pickerStack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            pickerStack.bottomAnchor.constraint(
                equalTo: closeButton.topAnchor,
                constant: -8
            ),
        ])
        
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(
            equalTo: pickerStack.widthAnchor
        ).isActive = true
    }
}


//MARK: - Setup Canvas
import SwiftUI
struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainViewController()
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
