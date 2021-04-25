//
//  CustomButtonCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 21.03.2021.
//

import UIKit
import SnapKit
import TableKit

struct CustomButtonCellActions {
    static let buttonTapped = "ButtonTapped"
}

struct CustomButtonCellConfiguration {
    var title: String
    var style: StyledButtonStyle
}

class CustomButtonCell: UITableViewCell, ConfigurableCell {

    // MARK: - Vars & Lets
    
    lazy var mainButton: StyledButton = {
        let button = StyledButton()
        button.setStyle(style: .filled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ConfigurableCell
    
    func configure(with configuration: CustomButtonCellConfiguration) {
        mainButton.setTitle(configuration.title, for: .normal)
        mainButton.setStyle(style: configuration.style)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        contentView.addSubview(mainButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        mainButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(5)
            make.height.equalTo(60)
            make.bottomMargin.equalToSuperview().offset(-5)
            make.leadingMargin.equalToSuperview().offset(16)
            make.trailingMargin.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func buttonTapped() {
        TableCellAction(key: CustomButtonCellActions.buttonTapped, sender: self).invoke()
    }
}
