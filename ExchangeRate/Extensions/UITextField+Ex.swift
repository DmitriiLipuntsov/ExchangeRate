//
//  UITextField+Ex.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 14.01.2023.
//

import UIKit

extension UITextField {
    func addUnderLine () {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height + 3, width: self.bounds.width, height: 1.5)
        bottomLine.backgroundColor = UIColor.convertorTextFieldUnderline.cgColor
        
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
