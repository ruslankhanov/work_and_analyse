//
//  TaskListViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import UIKit

class TaskListViewController: BaseViewController {
    
    // MARK: - Vars & Lets
    
    var viewModel: TaskListViewModelProtocol!
    
    private var dataToPresent: [SectionViewModel] {
        viewModel.dataToPresent
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.height)), style: .grouped)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        
        view.addSubview(tableView)
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(DetailTextViewCell.self, forCellReuseIdentifier: String(describing: DetailTextViewCell.self))
        tableView.register(OutlinedCell.self, forCellReuseIdentifier: String(describing: OutlinedCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadDataToPresent()
    }
}
extension TaskListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataToPresent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataToPresent[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = dataToPresent[indexPath.section].cells[indexPath.row]
        switch element.type {
        case .detailTextViewCell:
            let taskModel = element as? TaskViewModel
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTextViewCell.self), for: indexPath) as? DetailTextViewCell
            cell?.configure(with: DetailTextViewCellConfiguration(
                                mainText: taskModel?.title,
                                subtitleText: taskModel?.subtitle,
                                rightDetailText: taskModel?.rightDetailText,
                                isCompleted: taskModel?.isCompleted))
            return cell ?? UITableViewCell()
        case .outlineCell:
            let subtaskModel = element as? SubtaskViewModel
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OutlinedCell.self), for: indexPath) as? OutlinedCell
            cell?.configure(text: subtaskModel?.title ?? "", rightDetailText: subtaskModel?.rightDetailText, style: subtaskModel?.isCompleted ?? false ? .accepted : .normal)
            return cell ?? UITableViewCell()
        }
    }
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        LabelSectionHeaderView.getView(with: viewModel.dataToPresent[section].title ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let element = dataToPresent[indexPath.section].cells[indexPath.row] as? TaskViewModel else { return }
        
        if !element.children.isEmpty {
            let range = (indexPath.row + 1)...(indexPath.row + element.children.count)
            let indexPaths = range.getIndexPaths(in: indexPath.section)
            if element.isCollapsed {
                dataToPresent[indexPath.section].cells.insert(contentsOf: element.children, at: indexPath.row + 1)
                tableView.insertRows(at: indexPaths, with: .fade)
            } else {
                dataToPresent[indexPath.section].cells.removeSubrange(range)
                tableView.deleteRows(at: indexPaths, with: .fade)
            }
            
            element.isCollapsed = !element.isCollapsed
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let element = dataToPresent[indexPath.section].cells[indexPath.row]
        
        let action = UIContextualAction(style: .normal,
                                        title: nil) { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            self.viewModel.updateTask(with: element, at: indexPath)
            completionHandler(true)
        }
        
        if element.isCompleted {
            action.image = #imageLiteral(resourceName: "close").imageResized(to: CGSize(width: 40,height: 40))
        } else {
            action.image = #imageLiteral(resourceName: "check-mark-2").imageResized(to: CGSize(width: 40,height: 40))
        }
        
        action.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension TaskListViewController: TaskListViewModelDelegate {
    
    func didFailToLoadData(errorMessage: String) {
        showAlert(title: "Error", message: errorMessage)
    }
    
    func didLoadData() {
        tableView.reloadData()
    }
    
    func didUpdateData(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .left)
    }
}