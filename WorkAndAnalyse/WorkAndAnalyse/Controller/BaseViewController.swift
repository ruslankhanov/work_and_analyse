//
//  BaseViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.02.2021.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpBackground()
    }
    

    private func setUpBackground() {
        let image = UIImage(named: "background")
        let backgroundView = UIImageView(image: image)
        
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }

}
