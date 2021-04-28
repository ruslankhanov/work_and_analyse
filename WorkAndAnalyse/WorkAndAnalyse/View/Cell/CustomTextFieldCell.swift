//
//  CustomTextFieldCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 23.03.2021.
//

import UIKit
import SnapKit
import TableKit

struct CustomTextFieldCellActions {
    static let textFieldChanged = "TextFieldChanged"
}

class CustomTextFieldCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Vars & Lets
    
    var title = ""
    
    private lazy var textField: StyledTextField = {
        let textField = StyledTextField()
        textField.setStyle(style: .normal)
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return textField
    }()
    
    // MARK: - ConfigurableCell
    
    func configure(with placeholder: String) {
        textField.setPlaceholder(placeholder)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.addSubview(textField)
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
        textField.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(5)
            make.height.equalTo(45)
            make.bottomMargin.equalToSuperview().offset(-5)
            make.leadingMargin.equalToSuperview().offset(16)
            make.trailingMargin.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func textFieldChanged() {
        title = textField.text ?? ""
        TableCellAction(key: CustomTextFieldCellActions.textFieldChanged, sender: self).invoke()
    }
}
