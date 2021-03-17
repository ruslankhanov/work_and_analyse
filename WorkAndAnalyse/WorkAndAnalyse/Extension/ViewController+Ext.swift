//
//  ViewController+Ext.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 16.03.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
