//
//  SignUpViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 01.03.2021.
//

import UIKit

class SignUpViewController: ScrollableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sign Up"
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Configure views
    
    private let emailTextField: UITextField = {
        let textField = StyledTextField()
        textField.setPlaceholder("E-mail")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = StyledTextField()
        textField.isSecureTextEntry = true
        textField.setPlaceholder("Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = StyledTextField()
        textField.isSecureTextEntry = true
        textField.setPlaceholder("Confirm password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let signUpButton: UIButton = {
        let button = StyledFilledButton()
        button.setTitle("Create New Account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func setupViews() {
        centerStackView.addArrangedSubview(emailTextField)
        centerStackView.addArrangedSubview(passwordTextField)
        centerStackView.addArrangedSubview(confirmPasswordTextField)
        
        scrollView.addSubview(centerStackView)
        scrollView.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints{ make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints{ make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        confirmPasswordTextField.snp.makeConstraints{ make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        centerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view).multipliedBy(0.8)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(centerStackView.snp.bottom).offset(70)
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalTo(centerStackView)
            make.width.equalTo(centerStackView)
            make.height.equalTo(emailTextField.snp.height).offset(10)
        }
    }
}
