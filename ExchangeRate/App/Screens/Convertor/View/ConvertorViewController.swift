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
    private let scrollView = UIScrollView()
        
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
        setupScrollView()
        setupConvertorInfoView()
        setupConvertorView()
        
        setConstraints()
    }
    
    private func setupScrollView() {
        
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
        // convertorInfoView
        NSLayoutConstraint.activate([
            convertorInfoView.topAnchor.constraint(
                equalTo: view.layoutMarginsGuide.topAnchor,
                constant: .screenHeight * 0.02
            ),
            convertorInfoView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            convertorInfoView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            convertorInfoView.heightAnchor.constraint(
                equalToConstant: 93
            )
        ])
        
        NSLayoutConstraint.activate([
            convertorView.topAnchor.constraint(
                equalTo: convertorInfoView.bottomAnchor,
                constant: 20),
            convertorView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            convertorView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            convertorView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
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
