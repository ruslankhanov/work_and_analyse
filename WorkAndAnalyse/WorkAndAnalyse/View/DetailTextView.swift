//
//  DetailTextView.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.04.2021.
//

import UIKit
import SnapKit

enum DetailTextViewStyle {
    case filled
    case filledWithRightDetail
    case outline
}

class DetailTextView: UIView {
    
    // MARK: - Vars & Lets
    
    private var mainText: String?
    
    private var rightDetailText: String?
    
    private var subtitleText: String? {
        didSet {
            subtitleLabel.text = subtitleText ?? ""
        }
    }
    
    private let style: DetailTextViewStyle
    
    // MARK: - Subviews
    
    private lazy var rightView: UIView = {
        let rightView = UIView(frame: CGRect(x: frame.width - frame.width / 3, y: 0, width: frame.width / 3, height: frame.height))
        rightView.backgroundColor = CustomColors.lightBrownColor
        return rightView
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: frame.height / 2 - 15, width: frame.width / 2, height: 30))
        label.textColor = .white
        label.font = CustomFonts.openSans(size: 18, style: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 17, y: frame.maxY - 30, width: frame.width / 2, height: 20))
        label.textColor = CustomColors.creamWhiteColor
        label.font = CustomFonts.openSans(size: 13, style: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rightTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: frame.width - frame.width / 3, y: frame.height / 2 - 20, width: frame.width / 3, height: 40))
        label.textColor = .white
        label.font = CustomFonts.openSans(size: 17, style: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle

    override func layoutSubviews() {
        switch style {
        case .filled:
            backgroundColor = CustomColors.lightOrangeColor
        case .filledWithRightDetail:
            backgroundColor = CustomColors.lightOrangeColor
            addSubview(rightView)
            
            rightView.translatesAutoresizingMaskIntoConstraints = false
            rightView.snp.makeConstraints { make in
                make.trailingMargin.equalToSuperview()
                make.topMargin.equalToSuperview()
                make.bottom.equalToSuperview()
                make.width.equalTo(frame.width / 4)
            }
            
        case .outline:
            backgroundColor = .clear
            mainLabel.font = CustomFonts.openSans(size: 18, style: .regular)
            layer.borderWidth = 1
            layer.borderColor = CustomColors.lightOrangeColor.cgColor
        }
        
        if mainText != nil {
            mainLabel.text = mainText
            
            addSubview(stackView)
            
            stackView.addArrangedSubview(mainLabel)
            stackView.snp.makeConstraints { make in
                make.topMargin.equalToSuperview().offset(5)
                make.bottomMargin.equalToSuperview().offset(-2)
                make.leadingMargin.equalToSuperview().offset(16)
                make.width.equalTo(frame.width / 2)
            }
            
            if subtitleText != nil {
                subtitleLabel.text = subtitleText
                
                stackView.addArrangedSubview(subtitleLabel)
            }
        }
    
        if rightDetailText != nil {
            rightTextLabel.text = rightDetailText
            addSubview(rightTextLabel)
            
            rightTextLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(frame.width / 4)
            }
        }
        
        clipsToBounds = true
        layer.cornerRadius = 11
        
        super.layoutSubviews()
    }
    
    // MARK: - Init
    
    init(frame: CGRect = CGRect(), style: DetailTextViewStyle, mainText: String? = nil, rightDetailText: String? = nil, subtitleText: String? = nil) {
        self.style = style
        
        if let mainText = mainText {
            self.mainText = mainText
        }

        if let rightText = rightDetailText {
            self.rightDetailText = rightText
        }
        
        if let subtitleText = subtitleText {
            self.subtitleText = subtitleText
        }
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
