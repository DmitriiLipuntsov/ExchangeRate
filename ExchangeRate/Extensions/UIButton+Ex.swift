//
//  UIButton+Ex.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import UIKit

extension UIButton {
    func moveImageLeftTextCenter(image : UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderingMode), for: .normal)
        guard let imageViewWidth = self.imageView?.frame.width else { return }
//        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else { return }
        self.contentHorizontalAlignment = .left
        let imageLeft = imagePadding - imageViewWidth / 2
        let titleLeft = -15.0
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageLeft, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft , bottom: 0.0, right: 0.0)
    }
}
