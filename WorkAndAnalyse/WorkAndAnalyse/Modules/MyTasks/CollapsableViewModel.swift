//
//  CollapsableViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import Foundation

struct CollapsableViewModel {
    let title: String
    let subtitle: String?
    let rightDetailText: String
    let style: DetailTextViewStyle
    let children: [CollapsableViewModel]
    var isCollapsed: Bool
    
    init(title: String, subtitle: String? = nil, rightDetailText: String, style: DetailTextViewStyle, children: [CollapsableViewModel] = [], isCollapsed: Bool = true) {
        self.title = title
        self.subtitle = subtitle
        self.rightDetailText = rightDetailText
        self.style = style
        self.children = children
        self.isCollapsed = isCollapsed
    }
}
