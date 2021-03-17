//
//  StyledButton.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.02.2021.
//

import UIKit

class StyledFilledButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 11
        self.backgroundColor = CustomColors.lightOrangeColor
        self.setTitleColor(.white, for: .normal)
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributedString = NSAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: CustomFonts.openSans(size: 21, style: .bold)])
        super.setAttributedTitle(attributedString, for: state)
    }

}
