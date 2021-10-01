//
//  LoginViewController.swift
//  Music Bag
//
//  Created by Premier on 30/09/21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private var emailTextField: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .email, placeholder: "E-mail")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    private var passwordTextField: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .password, placeholder: "Password")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    
    private var siginButton: CustomButton = {
        let button = CustomButton(colorType: .light, title: "Signin")
        button.isEnabled = false
        button.addTarget(self, action: #selector(signinUser), for: .touchUpInside)
        return button
    }()
    
    private var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(openRegisterView), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string: "No have account? No problem!",
                                                     attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)]), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupView()
    }
    
    private func setupView() {
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        view.addSubview(siginButton)
        siginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(45)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(siginButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func verifyTextFields() {
        if emailTextField.textField.isValidEmail() && passwordTextField.textField.isValidPassword() && emailTextField.textField.text != "" && passwordTextField.textField.text != "" {
            self.siginButton.isEnabled = true
        } else {
            self.siginButton.isEnabled = false
            passwordTextField.alertMessageLabel.text = ""
        }
    }
    
    @objc
    private func signinUser() {
        guard let email = emailTextField.textField.text, let password = passwordTextField.textField.text else { return }
        FireBaseManager.shared.signIn(email: email, password: password) { result in
            switch result {
            case .failure(let error):
                self.showAlert(text: error.localizedDescription)
            case .success(_):
                self.navigationController?.pushViewController(ProfileViewController(), animated: true)
            }
        }
    }
    
    @objc
    private func openRegisterView() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
