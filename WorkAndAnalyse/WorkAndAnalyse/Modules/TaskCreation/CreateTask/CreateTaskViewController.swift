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
        let tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.height)))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Create Task"
        
        view.addSubview(tableView)
        
        // Configure table view
        tableView.backgroundColor = .clear
        
        tableDirector = TableDirector(tableView: tableView)
        
        configureSections()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y > 0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.setToolbarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
        }
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

