//
//  LabelSectionHeaderView.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.03.2021.
//

import UIKit
import SnapKit

class LabelSectionHeaderView: UIView {
    
    var title: String? {
        didSet {
            if let title = title {
                titleLabel.text = title
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 25, style: .bold)
        label.textColor = .white
        return label
    }()
    
    
    override func layoutSubviews() {
        self.addSubview(titleLabel)
        setupConstraints()
        super.layoutSubviews()
    }
    
    static func getView(with title: String) -> LabelSectionHeaderView {
        let headerView = LabelSectionHeaderView()
        headerView.title = title
        
        return headerView
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
    }
}
