//
//  StandartTextFieldCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.04.2021.
//

import UIKit
import TableKit

class StandartTextFieldCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Vars & Lets
    
    var title = ""
    
    private lazy var textField: UITextField = {
        let textField = EdgedTextField(frame: CGRect(origin: .zero, size: CGSize(width: contentView.frame.width, height: contentView.frame.height)))
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return textField
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = CustomColors.superDarkBlueColor

        contentView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigurableCell
    
    func configure(with placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: UIColor.lightGray
        ])
    }
    
    @objc private func textFieldChanged() {
        title = textField.text ?? ""
        TableCellAction(key: CustomTextFieldCellActions.textFieldChanged, sender: self).invoke()
    }
}
