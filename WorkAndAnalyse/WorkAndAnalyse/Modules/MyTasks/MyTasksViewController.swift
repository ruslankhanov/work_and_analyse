//
//  MyTasksViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import UIKit
import TableKit

class MyTasksViewController: BaseViewController {
    
    private var tableDirector: TableDirector!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.height)))
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My tasks"
        
        view.addSubview(tableView)
        
        // Configure table view
        tableView.backgroundColor = .clear
        
        tableDirector = TableDirector(tableView: tableView)
        //configureSections()
    }

}
