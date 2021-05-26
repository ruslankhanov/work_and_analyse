//
//  OutlinedCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.05.2021.
//

import UIKit

class OutlinedCell: UITableViewCell {
    
    enum Style {
        case normal
        case accepted
    }
    
    private var containerView = OutlinedView()
    private var acceptedView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColors.greenColor.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(text: String, rightDetailText: String? = nil, style: Style) {
        containerView.configure(text: text, rightDetailText: rightDetailText)
        switch style {
        case .accepted:
            acceptedView.isHidden = false
        case .normal:
            acceptedView.isHidden = true
        }
    }
    
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        
        acceptedView.isHidden = true
        
        addSubview(containerView)
        addSubview(acceptedView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-40)
        }
        acceptedView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }

}
