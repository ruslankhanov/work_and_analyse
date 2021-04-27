//
//  AddSubtaskViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 30.03.2021.
//

import UIKit
import TableKit

class AddSubtaskViewController: UIViewController {
    
    // MARK: - Vars & Lets
    
    var viewModel: AddSubtaskViewModelProtocol!
    
    private var tableDirector: TableDirector!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.height)))
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBar()
        
        view.addSubview(tableView)
        tableView.backgroundColor = CustomColors.darkBlueColor
        tableDirector = TableDirector(tableView: tableView)
        
        tableDirector += viewModel.dataToPresent
    }
    
    // MARK: - Private methods
    
    private func configureBar() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelTapped))
        
        var attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: CustomFonts.openSans(size: 16, style: .light)]
        saveButton.setTitleTextAttributes(attributes, for: .normal)
        cancelButton.setTitleTextAttributes(attributes, for: .normal)
        
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.lightGray
        
        saveButton.setTitleTextAttributes(attributes, for: .selected)
        cancelButton.setTitleTextAttributes(attributes, for: .selected)
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
        navigationItem.title = "Add subtask"
        navigationController?.navigationBar.barTintColor = CustomColors.superDarkBlueColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - Actions
    
    @objc private func saveTapped() {
        viewModel.saveTapped()
    }
    
    @objc private func cancelTapped() {
        viewModel.cancelTapped()
    }
    
}
