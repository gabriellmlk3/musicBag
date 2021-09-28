//
//  RegisterViewController.swift
//  Music Bag
//
//  Created by Premier on 26/09/21.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var firstNameTextFieldView: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .email, placeholder: "First Name")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    private var lastNameTextFieldView: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .email, placeholder: "Last Name")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    
    private var emailTextFieldView: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .email, placeholder: "E-mail")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    
    private var passwordTextFieldView: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .password, placeholder: "Password")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    
    private var confirmPasswordTextFieldView: CutomTextFieldView = {
        let textFieldView = CutomTextFieldView(colorType: .dark, type: .password, placeholder: "Confirm Password")
        textFieldView.textField.addTarget(self, action: #selector(verifyTextFields), for: .editingChanged)
        return textFieldView
    }()
    
    private var confirmButton: CustomButton = {
        let button = CustomButton(colorType: .light, title: "Signup")
        button.isEnabled = false
        button.addTarget(self, action: #selector(signupUser), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupView()
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(firstNameTextFieldView)
        firstNameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        scrollView.addSubview(lastNameTextFieldView)
        lastNameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextFieldView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        scrollView.addSubview(emailTextFieldView)
        emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextFieldView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        scrollView.addSubview(passwordTextFieldView)
        passwordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        scrollView.addSubview(confirmPasswordTextFieldView)
        confirmPasswordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        scrollView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextFieldView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
}

extension RegisterViewController {
    
    @objc
    private func verifyTextFields() {
        if emailTextFieldView.textField.isValidEmail() && passwordTextFieldView.textField.isValidPassword() && confirmPasswordTextFieldView.textField.isValidPassword() && firstNameTextFieldView.textField.text != "" && lastNameTextFieldView.textField.text != "" {
            self.confirmButton.isEnabled = true
        } else {
            self.confirmButton.isEnabled = false
            passwordTextFieldView.alertMessageLabel.text = ""
        }
    }
    
    private func verifyPasswords() -> Bool {
        if passwordTextFieldView.textField.text == confirmPasswordTextFieldView.textField.text {
            passwordTextFieldView.alertMessageLabel.text = ""
            return true
        } else {
            passwordTextFieldView.alertMessageLabel.text = "Passwords must be equal"
            return false
        }
    }
    
    @objc
    private func signupUser() {
        showLoad(subview: view)
        if verifyPasswords() {
            guard let firstName = firstNameTextFieldView.textField.text, let lastName = lastNameTextFieldView.textField.text, let email = emailTextFieldView.textField.text, let password = passwordTextFieldView.textField.text else { return }
            FireBaseManager.shared.createUser(firstName: firstName, lastName: lastName, email: email, password: password) { success, error in
                if success && error == nil {
                    self.dismissLoad()
                    self.showAlert(with: "User created succesfuly")
                } else if let error = error {
                    self.dismissLoad()
                    self.showAlert(with: "Erro on create new user. Error: \(error)")
                }
            }
        } else {
            self.dismissLoad()
        }
    }
    
}
