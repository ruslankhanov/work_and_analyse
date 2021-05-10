//
//  CreateTaskViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 17.03.2021.
//

import UIKit
import TableKit

class CreateTaskViewController: BaseViewController {
    
    // MARK: - Vars & Lets
    
    var viewModel: CreateTaskViewModelProtocol!
    
    private var tableDirector: TableDirector!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.height)), style: .grouped)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = "Create Task"
        
        view.addSubview(tableView)
        
        // Configure table view
        tableView.backgroundColor = CustomColors.darkBlueColor
        
        tableDirector = TableDirector(tableView: tableView)
        
        configureSections()
    }
    
    // MARK: - Private methods
    
    private func configureSections() {
        viewModel.dataToPresent.forEach {
            $0.headerHeight = 45.0
        }
        
        tableDirector += viewModel.dataToPresent
    }
}

extension CreateTaskViewController: CreaTaskViewModelDelegate {
    func didUpdateData() {
        tableView.reloadData()
    }
    
    func didFailTaskCreation(errorMessage: String) {
        showAlert(title: "Error", message: errorMessage)
    }
}

