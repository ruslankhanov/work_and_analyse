//
//  DetailTextViewCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

import UIKit
import TableKit

struct DetailTextViewCellConfiguration {
    var mainText: String?
    var subtitleText: String?
    var rightDetailText: String?
    
    init(mainText: String? = nil, subtitleText: String? = nil, rightDetailText: String? = nil) {
        self.mainText = mainText
        self.subtitleText = subtitleText
        self.rightDetailText = rightDetailText
    }
}

class DetailTextViewCell: UITableViewCell, ConfigurableCell {
    
    private var containerView: UIView = DetailTextView(style: .outline)
    
    func configure(with config: DetailTextViewCellConfiguration) {
        containerView = DetailTextView(style: .filledWithRightDetail, mainText: config.mainText, rightDetailText: config.rightDetailText, subtitleText: config.subtitleText)
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.topMargin.equalToSuperview().offset(5)
            make.bottomMargin.equalToSuperview().offset(-5)
            make.leadingMargin.equalToSuperview().offset(16)
            make.trailingMargin.equalToSuperview().offset(-16)
        }
        
        super.layoutSubviews()
    }
}
