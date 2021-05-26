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
    
    static func getInstance(title: String, style: StyledButtonStyle) -> StyledButton {
        let button = StyledButton()
        button.setTitle(title, for: .normal)
        button.setStyle(style: style)
        
        return button
    }
    
    var action: (() -> Void) {
        didSet {
            addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        }
    }
    
    init() {
        action = {}
        super.init(frame: CGRect())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        action = {}
        super.init(coder: coder)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributedString = NSAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: CustomFonts.openSans(size: 25, style: .bold)])
        super.setAttributedTitle(attributedString, for: state)
    }

    func setStyle(style: StyledButtonStyle) {
        switch style {
        case .filled:
            backgroundColor = CustomColors.lightOrangeColor
            setBackgroundColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)
        case .outline:
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = CustomColors.lightOrangeColor.cgColor
            setBackgroundColor(CustomColors.lightOrangeColor.withAlphaComponent(0.2), for: .highlighted)
        }
    }
    
    private func commonInit() {
        layer.cornerRadius = 11
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        
    }
    
    @objc private func tapButton() {
        action()
    }
}
