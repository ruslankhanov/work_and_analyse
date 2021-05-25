//
//  OutlinedView.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.05.2021.
//

import UIKit

class OutlinedView: UIView {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = CustomFonts.openSans(size: 18, style: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = CustomFonts.openSans(size: 17, style: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(text: String, rightDetailText: String? = nil) {
        mainLabel.text = text
        if let rightDetailText = rightDetailText {
            rightTextLabel.text = rightDetailText
            rightTextLabel.isHidden = false
        } else {
            rightTextLabel.isHidden = true
        }
    }
    
    private func commonInit() {
        backgroundColor = .clear
        mainLabel.font = CustomFonts.openSans(size: 18, style: .regular)
        layer.borderWidth = 1
        layer.borderColor = CustomColors.lightOrangeColor.cgColor
        clipsToBounds = true
        layer.cornerRadius = 11
        
        addSubview(mainLabel)
        addSubview(rightTextLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(200)
        }
        
        rightTextLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(100)
        }
    }
}
