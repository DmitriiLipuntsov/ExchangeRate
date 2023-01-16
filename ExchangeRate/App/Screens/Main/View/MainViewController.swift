//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 11.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    private let datePickerButton = UIButton()
    
    private let datePickerView = DatePickerView()
    private let activitiIndicator = UIActivityIndicatorView()
    private let errorLabel = UILabel()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let sizeItem: CGFloat = .screenWidth / 3 - 21
        layout.itemSize = CGSize(width: sizeItem, height: sizeItem + 6)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let dateFormatter: DateFormatter =  {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Валюты"
        
        setupUI()
    }
    
    private func setupUI() {
        setupDatePickerButton()
        setupCollectionView()
        setupActivitiIndicator()
        setupErrorLabel()
        setupDatePickerView()
        
        setConstraints()
    }
    
    private func setupDatePickerView() {
        datePickerView.isHidden = true
        datePickerView.datePicker.dataSource = self
        datePickerView.datePicker.delegate = self
        datePickerView.delegate = self
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePickerView)
        
        datePickerView.datePicker.selectRow(presenter.setSelectedDate(), inComponent: 0, animated: true)
    }
    
    private func setupActivitiIndicator() {
        activitiIndicator.style = .large
        activitiIndicator.startAnimating()
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activitiIndicator)
    }
    
    private func setupDatePickerButton() {
        let image = UIImage(named: "Calendar")
        
        datePickerButton.setTitle(presenter.currentDateText, for: .normal)
        datePickerButton.setTitleColor(.black, for: .normal)
        datePickerButton.moveImageLeftTextCenter(
            image: image ?? UIImage(),
            imagePadding: .screenWidth - 82,
            renderingMode: .alwaysOriginal
        )
        datePickerButton.imageView?.contentMode = .scaleAspectFit
        datePickerButton.backgroundColor = .clear
        datePickerButton.layer.borderWidth = 1
        datePickerButton.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        datePickerButton.layer.cornerRadius = 6
        datePickerButton.clipsToBounds = true
        
        datePickerButton.addTarget(self, action: #selector(datePickerButtonAction), for: .touchUpInside)
        
        datePickerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePickerButton)
    }
    
    @objc private func datePickerButtonAction() {
        datePickerView.isHidden = false
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
        collectionView.register(CurrancyCell.self, forCellWithReuseIdentifier: CurrancyCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func setupErrorLabel() {
        errorLabel.text = "Выходной день"
        errorLabel.isHidden = true
        errorLabel.backgroundColor = .pickerBackground
        errorLabel.textAlignment = .center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorLabel)
    }
}

//MARK: - Setup contstraints
extension MainViewController {
    private func setConstraints() {
        // ActivitiIndicator
        NSLayoutConstraint.activate([
            activitiIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            activitiIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor)
        ])
        
        // DateTextField
        NSLayoutConstraint.activate([
            datePickerButton.topAnchor.constraint(
                equalTo: view.layoutMarginsGuide.topAnchor,
                constant: 24),
            datePickerButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 23),
            datePickerButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -23),
            datePickerButton.heightAnchor.constraint(
                equalToConstant: 40
            )
        ])
        
        // DatePickerView
        NSLayoutConstraint.activate([
            datePickerView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            datePickerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            datePickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            datePickerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])
        
        // CollectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: datePickerButton.bottomAnchor,
                constant: 20),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.layoutMarginsGuide.bottomAnchor,
                constant: -15)
        ])
        
        // errorLabel
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(
                equalTo: datePickerButton.bottomAnchor,
                constant: 20),
            errorLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            errorLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            errorLabel.bottomAnchor.constraint(
                equalTo: view.layoutMarginsGuide.bottomAnchor,
                constant: -15)
        ])
    }
}

//MARK: - UIPickerViewDataSource
extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.dateCollection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        datePickerView.saveButtonIsEnabled(false)
        let label = dateFormatter.string(from: presenter.dateCollection[row])
        return label
    }
}

// MARK: - UIPickerViewDelegate
extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        datePickerView.saveButtonIsEnabled(true)
        presenter.datePickerSelect(row: row)
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func succes() {
        errorLabel.isHidden = true
        activitiIndicator.isHidden = true
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        activitiIndicator.isHidden = true
        errorLabel.isHidden = false
    }
    
    func dateChanged(to stringDate: String) {
        activitiIndicator.isHidden = false
        datePickerButton.setTitle(stringDate, for: .normal)
    }
}

//MARK: - DatePickerViewDelegate
extension MainViewController: DatePickerViewDelegate {
    func saveButtonPressed() {
        datePickerView.isHidden = true
        presenter.saveButtonPressed()
    }
    
    func closeButtonPressed() {
        datePickerView.isHidden = true
        presenter.closeButtonPressed()
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.tapOnTheCell(index: indexPath.row)
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrancyCell.identifier,
                for: indexPath
            ) as? CurrancyCell
        else {
            return CurrancyCell()
        }
        
        let model = presenter.currencies[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}

//MARK: - Setup Canvas
//import SwiftUI
//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let viewController = MainViewController()
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
