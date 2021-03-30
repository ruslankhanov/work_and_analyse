//
//  SignInViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.02.2021.
//

import UIKit
import SnapKit

class SignInViewController: ScrollableViewController {
    
    // MARK: - Vars & Lets
    
    var viewModel: (SignInViewModelProtocol & SignInOutput)!
    
    private let emailTextField: UITextField = {
        let textField = StyledTextField()
        textField.setStyle(style: .outline)
        textField.setPlaceholder("E-mail")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = StyledTextField()
        textField.isSecureTextEntry = true
        textField.setStyle(style: .outline)
        textField.setPlaceholder("Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signInButton: StyledButton = {
        var button = StyledButton()
        button.setTitle("Sign In", for: .normal)
        button.setStyle(style: .filled)
        button.addTarget(self, action: #selector(signInTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(signUpTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 40, style: .bold)
        label.text = "Hey,\nLogin Now."
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 16, style: .regular)
        label.text = "If you are new /"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
        setUpBindings()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - View methods
    
    private func setupViews() {
        centerStackView.addArrangedSubview(emailTextField)
        centerStackView.addArrangedSubview(passwordTextField)
        
        topStackView.addArrangedSubview(secondaryLabel)
        topStackView.addArrangedSubview(signUpButton)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(topStackView)
        scrollView.addSubview(centerStackView)
        scrollView.addSubview(signInButton)
        
        emailTextField.snp.makeConstraints{ make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints{ make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * 0.1)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.3).offset(-50)
        }
        
        topStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(40)
            make.centerX.equalTo(titleLabel)
            make.width.equalTo(view).multipliedBy(0.8)
        }
        
        signInButton.snp.makeConstraints{ make in
            make.top.equalTo(centerStackView.snp.bottom).offset(70)
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalTo(titleLabel)
            make.width.equalTo(centerStackView)
            make.height.equalTo(emailTextField.snp.height).offset(10)
        }
    }
    
    // MARK: - ViewModel methods
    
    private func setUpBindings() {
        emailTextField.addTarget(self, action: #selector(credentialsChanged), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(credentialsChanged), for: UIControl.Event.editingChanged)
        
    }
    
    @objc private func credentialsChanged() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
    }
    
    @objc private func signUpTap() {
        viewModel.signUpTap()
    }
    
    @objc private func signInTap() {
        viewModel.signInTap()
    }
}
