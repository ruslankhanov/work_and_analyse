//
//  CreateTaskViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 17.03.2021.
//

import UIKit
import SnapKit

class CreateTaskViewController: UITableViewController {
    // MARK: - Vars & Lets
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Create Task"
        
        let image = UIImage(named: "background")
        let backgroundView = UIImageView(image: image)
        
        tableView.backgroundView = backgroundView
    }
    
    // MARK: - Table View
    
}

