//
//  UISearchBar.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/13/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

//MARK: - UISearchBar

extension UISearchBar {

    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }
    
    func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
    
    func setIconToRight() {
        let image = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: image)
        searchTextField.rightView = imageView
        searchTextField.leftView = nil
        searchTextField.rightViewMode = .always
    }
    
    func customSearchBar() {
        
        self.placeholder = "Search for deals"
        self.setPlaceholder(textColor: UIColor(rgb: 0xFFFFFF))
        self.setTextField(color: UIColor(rgb: 0xD8D8D8))
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
        self.setSearchImage(color: UIColor(rgb: 0xEE2F4D))
        self.searchTextField.layer.cornerRadius = 20
        self.searchTextField.layer.masksToBounds = true
    }
    
}
