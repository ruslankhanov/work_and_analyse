//
//  UIHelper.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.02.2021.
//

import UIKit

enum Style: String {
    case light = "Light"
    case regular = "Regular"
    case semibold = "SemiBold"
    case bold = "Bold"
}

class CustomFonts {
    
    static func openSans(size: CGFloat, style: Style) -> UIFont {
        return UIFont(name: "OpenSans-\(style.rawValue)", size: size) ?? UIFont()
    }
}

