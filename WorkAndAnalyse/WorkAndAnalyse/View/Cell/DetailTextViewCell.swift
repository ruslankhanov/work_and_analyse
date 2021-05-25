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
    var isCompleted: Bool?

    init(mainText: String? = nil, subtitleText: String? = nil, rightDetailText: String? = nil, isCompleted: Bool? = nil) {
        self.mainText = mainText
        self.subtitleText = subtitleText
        self.rightDetailText = rightDetailText
        self.isCompleted = isCompleted
    }
}

class DetailTextViewCell: UITableViewCell, ConfigurableCell {
    
    private var defaultView = RightDetailSubtitledView()
    
    func configure(with config: DetailTextViewCellConfiguration) {
        defaultView.configure(mainText: config.mainText, rightDetailText: config.rightDetailText, subtitleText: config.subtitleText, isCompleted: config.isCompleted ?? false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
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
        
    }
}
