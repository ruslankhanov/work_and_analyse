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
    
    var delegate: UITableViewDelegate?
    var dataSource: UITableViewDataSource?
    
    init(mainText: String? = nil, subtitleText: String? = nil, rightDetailText: String? = nil) {
        self.mainText = mainText
        self.subtitleText = subtitleText
        self.rightDetailText = rightDetailText
    }
}

class DetailTextViewCell: UITableViewCell, ConfigurableCell {
    
    private var defaultView = RightDetailSubtitledView()
    
    func configure(with config: DetailTextViewCellConfiguration) {
        defaultView.configure(mainText: config.mainText, rightDetailText: config.rightDetailText, subtitleText: config.subtitleText)
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        defaultView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(defaultView)
    
        defaultView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        super.layoutSubviews()
    }
}
