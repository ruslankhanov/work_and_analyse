//
//  DatePickerCell.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.04.2021.
//

import UIKit
import TableKit
import SnapKit

typealias PickerData = [(title: String, rows: [Int])]

struct PickerViewCellActions {
    static let selectedValueChanged = "SelectedValueChanged"
}

class PickerViewCell: UITableViewCell, ConfigurableCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerResult: [Int] = []
    
    private var pickerData: PickerData = []
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView(frame: CGRect(origin: .zero, size: CGSize(width: contentView.frame.width, height: contentView.frame.height)))
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(pickerView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData[component].rows.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let suffix = pickerData[component].title
        
        let attributedString = NSMutableAttributedString(string:"\(row) ", attributes: [
            .font: CustomFonts.openSans(size: 20, style: .regular),
            .foregroundColor: UIColor.white
        ])
        
        attributedString.append(NSMutableAttributedString(string: suffix, attributes: [
            .font: CustomFonts.openSans(size: 20, style: .bold),
            .foregroundColor: UIColor.white
        ]))
        
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.attributedText = attributedString
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerResult = (0...pickerView.numberOfComponents - 1).map {
            pickerData[$0].rows[pickerView.selectedRow(inComponent: $0)]
        }
        TableCellAction(key: PickerViewCellActions.selectedValueChanged, sender: self).invoke()
    }
    
    func configure(with data: PickerData) {
        pickerData = data
    }
    
    private func setupConstraints() {
        pickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
