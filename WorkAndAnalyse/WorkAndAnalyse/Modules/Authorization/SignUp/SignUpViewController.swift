//
//  SignUpViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 01.03.2021.
//

import UIKit

class SignUpViewController: ScrollableViewController {
    
    // MARK: - Vars & Lets
    
    var viewModel: (SignUpViewModelProtocol & SignUpOutput)!
    
    private let usernameTextField: UITextField = {
        let textField = StyledTextField()
        textField.setStyle(style: .outline)
        textField.setPlaceholder("Username")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = StyledTextField()
        textField.setStyle(style: .outline)
        textField.setPlaceholder("E-mail")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = StyledTextField()
        //textField.isSecureTextEntry = true
        textField.setStyle(style: .outline)
        textField.setPlaceholder("Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = StyledTextField()
        //textField.isSecureTextEntry = true
        textField.setStyle(style: .outline)
        textField.setPlaceholder("Confirm password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let signUpButton: UIButton = {
        let button = StyledButton()
        button.setTitle("Sign Up", for: .normal)
        button.setStyle(style: .filled)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signUpTap), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Create New Account"
        
        setupViews()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - View methods
    
    private func setupViews() {
        centerStackView.addArrangedSubview(usernameTextField)
        centerStackView.addArrangedSubview(emailTextField)
        centerStackView.addArrangedSubview(passwordTextField)
        centerStackView.addArrangedSubview(confirmPasswordTextField)
        
        scrollView.addSubview(centerStackView)
        scrollView.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints{ make in
            make.height.equalTo(50)
        }
        
        usernameTextField.snp.makeConstraints{ make in
            make.height.equalTo(emailTextField.snp.height)
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
    
    // MARK: - ViewModel methods
    
    private func setupBindings() {
        emailTextField.addTarget(self, action: #selector(credentialsChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(credentialsChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(credentialsChanged), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(credentialsChanged), for: .editingChanged)
    }
    
    @objc private func credentialsChanged() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.username = usernameTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.passwordConfirmation = passwordTextField.text ?? ""
    }
    
    @objc private func signUpTap() {
        viewModel.signUpTap()
    }
}
