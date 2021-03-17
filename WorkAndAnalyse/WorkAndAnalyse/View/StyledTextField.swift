//
//  StyledTextField.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.02.2021.

//

import UIKit

class StyledTextField: UITextField {
        
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = CustomColors.lightOrangeColor.cgColor
        self.layer.cornerRadius = 11.0
        self.layer.masksToBounds = true
        self.backgroundColor = .none
        self.textColor = .white
        self.autocapitalizationType = .none
        self.font = CustomFonts.openSans(size: 18, style: .regular)
        self.autocorrectionType = .no
    }
    
    func setPlaceholder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}
