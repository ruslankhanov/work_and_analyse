//
//  StyledTextField.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.02.2021.

//

import UIKit

enum StyledTextFieldStyle {
    case outline
    case normal
}

class StyledTextField: EdgedTextField {
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 11.0
        self.layer.masksToBounds = true
        self.autocapitalizationType = .none
        self.font = CustomFonts.openSans(size: 18, style: .regular)
        self.autocorrectionType = .no
    }
    
    func setPlaceholder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func setStyle(style: StyledTextFieldStyle) {
        switch style {
        case .outline:
            self.layer.borderWidth = 1.0
            self.layer.borderColor = CustomColors.lightOrangeColor.cgColor
            self.backgroundColor = .none
            self.textColor = .white
        case .normal:
            self.backgroundColor = .white
            self.textColor = .black
        }
    }
}
