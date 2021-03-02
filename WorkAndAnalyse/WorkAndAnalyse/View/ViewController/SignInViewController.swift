//
//  SignInViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.02.2021.
//

import UIKit
import SnapKit

class SignInViewController: ScrollableViewController {
    
    var onFinishSignUp: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Configure views
    
    let emailTextField: UITextField = {
        let textField = StyledTextField()
        textField.setPlaceholder("E-mail")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = StyledTextField()
        textField.isSecureTextEntry = true
        textField.setPlaceholder("Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = StyledFilledButton()
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signUpTap), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 40, style: .bold)
        label.text = "Hey,\nLogin Now."
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.openSans(size: 16, style: .regular)
        label.text = "If you are new /"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
    
    // MARK: - Navigation
    
    @objc private func signUpTap() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
