//
//  ConvertorViewController.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 13.01.2023.
//

import UIKit

class ConvertorViewController: UIViewController {
    
    var presentor: ConvertorPresenterProtocol!
    
    private var navTitle: String?
    
    private let convertorInfoView = ConvertorInfoView()
    private let convertorView = ConvertorView()
    private let backgroundView = UIView()
    private let scrollView = UIScrollView()
    private let scrollStackViewContainer = UIStackView()
    
    init(navTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        self.navTitle = navTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cellBackground
        navigationItem.title = navTitle
        
        setupUI()
    }
    
    private func setupUI() {
        setupBackgroundView()
        setupConvertorInfoView()
        setupConvertorView()
        setupScrollView()
        setupStackView()
        
        setConstraints()
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        configureContainerView()
    }
    
    private func setupStackView() {
        scrollStackViewContainer.axis = .vertical
        scrollStackViewContainer.spacing = 0
        scrollStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureContainerView() {
        scrollStackViewContainer.addArrangedSubview(convertorInfoView)
        scrollStackViewContainer.addArrangedSubview(convertorView)
    }
    
    private func setupConvertorInfoView() {
        convertorInfoView.translatesAutoresizingMaskIntoConstraints = false
        convertorInfoView.configure(title: presentor.currancyData.name, value: presentor.currancyData.value)
        view.addSubview(convertorInfoView)
    }
    
    private func setupConvertorView() {
        convertorView.translatesAutoresizingMaskIntoConstraints = false
        convertorView.configure(currencyCode: presentor.currancyData.title)
        view.addSubview(convertorView)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presentor.currencyChanged(value: text)
    }
    
    @objc func rubTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presentor.rubChanged(value: text)
    }
    
}

//MARK: - Setup contstraints
extension ConvertorViewController {
    private func setConstraints() {
        setBackgroundViewConstraints()
        setScrollViewConstraints()
        setStackViewConstraints()
        
        // convertorInfoView
        NSLayoutConstraint.activate([
            convertorInfoView.heightAnchor.constraint(
                equalToConstant: 113
            )
        ])
        
        // convertorView
        NSLayoutConstraint.activate([
            convertorView.heightAnchor.constraint(
                equalToConstant: 486
            ),
        ])
    }
    
    private func setBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            backgroundView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            backgroundView.heightAnchor.constraint(
                equalToConstant: .screenHeight / 2
            )
        ])
    }
    
    private func setScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.layoutMarginsGuide.topAnchor,
                constant: 20
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.layoutMarginsGuide.bottomAnchor
            )
        ])
    }
    
    private func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            scrollStackViewContainer.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),
            scrollStackViewContainer.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),
            scrollStackViewContainer.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),
            scrollStackViewContainer.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),
            scrollStackViewContainer.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor
            )
        ])
    }
}

////MARK: - ConvertorViewProtocol
//extension ConvertorViewController: UITextFieldDelegate {
//
//}

//MARK: - ConvertorViewProtocol
extension ConvertorViewController: ConvertorViewProtocol {
    func setNewValues(model: ExchangeRateModel) {
        convertorView.setNewValues(model: model)
    }
}

//MARK: - Setup Canvas
import SwiftUI
struct ConvertorViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ConvertorViewController(navTitle: "title")
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
