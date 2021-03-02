//
//  SignUpViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 01.03.2021.
//

import UIKit

class SignUpViewController: ScrollableViewController {
    
    var viewModel = UserViewModel()
    
    // MARK: - Lifecycle

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
    
    // MARK: - Navigation
    
    func transitionToHome() {
        
        //let homeViewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Configure views
    
    private let usernameTextField: UITextField = {
        let textField = StyledTextField()
        textField.setPlaceholder("Username")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = StyledTextField()
        textField.setPlaceholder("E-mail")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = StyledTextField()
        //textField.isSecureTextEntry = true
        textField.setPlaceholder("Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = StyledTextField()
        //textField.isSecureTextEntry = true
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
        let button = StyledFilledButton()
        button.setTitle("Create New Account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signUpTap), for: .touchUpInside)
        
        return button
    }()

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
    
    @objc private func signUpTap() {
        if let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text, let passwordConfirmation = confirmPasswordTextField.text {
            
            viewModel.register(email: email, username: username, password: password, passwordConfirmation: passwordConfirmation) { [weak self] error in
                self?.showSimpleAlert(title: "Message", message: error)
            }
        }
    }
    
    private func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
