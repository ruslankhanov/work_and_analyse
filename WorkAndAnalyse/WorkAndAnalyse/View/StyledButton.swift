//
//  StyledButton.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.02.2021.
//

import UIKit

enum StyledButtonStyle {
    case filled
    case outline
}

class StyledButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 11
        self.clipsToBounds = true
        self.setTitleColor(.white, for: .normal)
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributedString = NSAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: CustomFonts.openSans(size: 25, style: .bold)])
        super.setAttributedTitle(attributedString, for: state)
    }

    func setStyle(style: StyledButtonStyle) {
        switch style {
        case .filled:
            self.backgroundColor = CustomColors.lightOrangeColor
        case .outline:
            self.backgroundColor = .clear
            self.layer.borderWidth = 1
            self.layer.borderColor = CustomColors.lightOrangeColor.cgColor
        }
    }
}
