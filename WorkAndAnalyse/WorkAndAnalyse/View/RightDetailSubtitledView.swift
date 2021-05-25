//
//  DetailTextView.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.04.2021.
//

import UIKit
import SnapKit

class RightDetailSubtitledView: UIView {
    
    // MARK: - Subviews
    
    private lazy var rightView: UIView = {
        let rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false
        return rightView
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = CustomFonts.openSans(size: 18, style: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.creamWhiteColor
        label.font = CustomFonts.openSans(size: 13, style: .regular)
        label.numberOfLines = 0
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: CGRect())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    
    func configure(mainText: String? = nil, rightDetailText: String? = nil, subtitleText: String? = nil, isCompleted: Bool) {
        if isCompleted {
            backgroundColor = CustomColors.greenColor
            rightView.backgroundColor = CustomColors.greenColor
        } else {
            backgroundColor = CustomColors.lightOrangeColor
            rightView.backgroundColor = CustomColors.lightBrownColor
        }
        
        if let mainText = mainText {
            mainLabel.text = mainText
        } else {
            mainLabel.isHidden = true
        }
        
        if let rightDetailText = rightDetailText {
            rightTextLabel.text = rightDetailText
        } else {
            rightTextLabel.isHidden = true
            rightView.isHidden = true
        }
        
        if let subtitleText = subtitleText {
            subtitleLabel.text = subtitleText
        } else {
            subtitleLabel.isHidden = true
        }
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        clipsToBounds = true
        layer.cornerRadius = 11
        
        addSubview(stackView)
        addSubview(rightView)
        addSubview(rightTextLabel)

        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        rightView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
                
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(rightView).offset(-5)
        }

        rightTextLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
    }
}
