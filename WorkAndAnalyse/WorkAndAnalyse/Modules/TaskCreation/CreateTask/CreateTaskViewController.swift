//
//  CreateTaskViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 17.03.2021.
//

import UIKit
import TableKit

protocol CreateTaskViewControllerProtocol {
    var onGoToSubtaskCreation: (() -> Void)? { get set }
}

class CreateTaskViewController: UITableViewController, CreateTaskViewControllerProtocol {
    
    // MARK: - Vars & Lets
    
    var viewModel: CreateTaskViewModelProtocol!
    
    var tableDirector: TableDirector!
    
    // MARK: - CreateTaskViewControllerProtocol
    
    var onGoToSubtaskCreation: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Create Task"
        
        let image = UIImage(named: "background")
        let backgroundView = UIImageView(image: image)
        
        // Configure table view
        tableView.backgroundView = backgroundView
        
        tableDirector = TableDirector(tableView: tableView)
        
        configureSections()
    }
    
    // MARK: - Private methods
    
    private func configureSections() {
        //
        let createAction = TableRowAction<CustomButtonCell>(.custom(CustomButtonCellActions.buttonTapped)) { [weak self] (options) in
            self?.viewModel.create()
        }
        let titleEdited = TableRowAction<CustomTextFieldCell>(.custom(CustomTextFieldCellActions.textFieldChanged)) { [weak self] (options) in
            self?.viewModel.title = options.item
        }
        let addSubtaskAction = TableRowAction<CustomButtonCell>(.custom(CustomButtonCellActions.buttonTapped)) { [weak self] (options) in
            self?.onGoToSubtaskCreation?()
        }
        
        let titleTextFieldRow = TableRow<CustomTextFieldCell>(item: "Type some title for your task...", actions: [titleEdited])
        let createButtonRow = TableRow<CustomButtonCell>(item: CustomButtonCellConfiguration(title: "CREATE", style: .filled), actions: [createAction])
        
        let headerView = LabelSectionHeaderView()
        headerView.title = "Title"
        let section = TableSection(headerView: headerView, footerView: UIView(), rows: [titleTextFieldRow, createButtonRow])
        section.headerHeight = 45.0
        tableDirector += section
        
        //
        
        let addButtonRow = TableRow<CustomButtonCell>(item: CustomButtonCellConfiguration(title: "+", style: .outline), actions: [addSubtaskAction])
        
        let anotherHeaderView = LabelSectionHeaderView()
        anotherHeaderView.title = "Subtasks"
        
        let section1 = TableSection(headerView: anotherHeaderView, footerView: UIView(), rows: [addButtonRow])
        section1.headerHeight = 45.0
        tableDirector += section1
        
    }
    
    private func setupBindings() {
        //
    }
}

