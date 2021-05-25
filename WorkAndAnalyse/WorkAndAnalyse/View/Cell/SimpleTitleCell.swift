//
//  SimpleTitleCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 23.05.2021.
//

import UIKit

class SimpleTitleCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 18, style: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        super.layoutSubviews()
    }

}
