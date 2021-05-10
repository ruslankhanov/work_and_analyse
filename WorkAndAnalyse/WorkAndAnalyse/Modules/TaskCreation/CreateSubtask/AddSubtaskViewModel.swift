//
//  AddSubtaskViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.04.2021.
//

import TableKit

protocol AddSubtaskViewModelDelegate: AnyObject {
    func createSubtask(subtask: Subtask)
}

protocol AddSubtaskViewModelOutput {
    var onFinish: (() -> Void)? { get set }
}

protocol AddSubtaskViewModelProtocol {
    var dataToPresent: [TableSection] { get set }
    
    func saveTapped()
    func cancelTapped()
}

class AddSubtaskViewModel: AddSubtaskViewModelProtocol, AddSubtaskViewModelOutput {
    
    // MARK: - Vars & Lets
    
    var dataToPresent: [TableSection] = []
    unowned var delegate: AddSubtaskViewModelDelegate!
    
    var onFinish: (() -> Void)?
    
    private var title: String?
    private var duration: TimeInterval?
    
    // MARK: - Init
    
    init() {
        loadSectionData()
    }
    
    // MARK: - Public methods
    
    func saveTapped() {
        guard let title = title, !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let duration = duration, duration != .zero else {
            return
        }
        
        let subtask = Subtask(title: title, duration: duration, completed: false)
        delegate.createSubtask(subtask: subtask)
        onFinish?()
    }
    
    func cancelTapped() {
        onFinish?()
    }
    
    // MARK: - Private methods
    
    private func loadSectionData() {
        dataToPresent = [
            TableSection(headerView: UIView(), footerView: UIView(), rows: [
                TableRow<PickerViewCell>(item: [
                    ("h", Array(0...23)),
                    ("m", Array(0...59)),
                    ("s", Array(0...59))
                ], actions: [
                    TableRowAction<PickerViewCell>(.custom(PickerViewCellActions.selectedValueChanged)) { [unowned self] options in
                        if let result = options.cell?.pickerResult {
                            updateDuration(with: result)
                        }
                    }
                ]),
                TableRow<StandartTextFieldCell>(item: "Title", actions: [
                    TableRowAction<StandartTextFieldCell>(.custom(CustomTextFieldCellActions.textFieldChanged)) { [unowned self] options in
                        if let result = options.cell?.title {
                            updateTitle(with: result)
                        }
                    }
                ])
            ])
        ]
    }
    
    private func updateDuration(with value: [Int]) {
        let hours = value[0] * 3600
        let mins = value[1] * 60
        let seconds = value[2]
        duration = TimeInterval(hours + mins + seconds)
    }
    
    private func updateTitle(with value: String) {
        title = value
    }
}
