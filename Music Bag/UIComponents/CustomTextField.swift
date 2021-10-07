//
//  CustomTextField.swift
//  Music Bag
//
//  Created by Premier on 27/09/21.
//

import UIKit

enum TextFieldType {
    case email
    case password
}

enum TextFieldColorType {
    case dark
    case light
    
    var backGoundColor: UIColor {
        switch self {
        case .dark:
            return .black1E2125
        case .light:
            return .white
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .dark:
            return .white
        case .light:
            return .black1E2125
        }
    }
}

class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 55)
    var colorType: TextFieldColorType
    var type: TextFieldType
    
    private let eyePasswordButton = UIButton()
    
    init(colorType: TextFieldColorType, type: TextFieldType, placeholder: String?) {
        self.colorType = colorType
        self.type = type
        super.init(frame: .zero)
        
        setupTextField()
        self.addShadow(shadowOpacity: 0, shadowRadius: 10)
        self.delegate = self
        self.backgroundColor = colorType.backGoundColor
        self.textColor = colorType.textColor
        self.layer.cornerRadius = 5
        self.tintColor = .white
        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                                                                     NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15)])
    }
    
    private func setupTextField() {
        switch type {
        case .email:
            keyboardType = .emailAddress
            autocapitalizationType = .none
        case .password:
            addEyePasswordView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomTextField {
    
    func isValidEmail() -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = self.text?.range(of: emailPattern, options: .regularExpression)
        return result != nil
    }
    
    func isValidPassword() -> Bool {
        let passwordPattern = #"(?=.{6,})"#
        let result = self.text?.range(of: passwordPattern, options: .regularExpression)
        return result != nil
    }
    
    private func addEyePasswordView() {
        rightView = eyePasswordButton
        rightViewMode = .always
        isSecureTextEntry = true
        eyePasswordButton.setImage(.eyeIcon, for: .normal)
        eyePasswordButton.tintColor = .systemGray
        eyePasswordButton.addTarget(self, action: #selector(togglePasswordText), for: .touchUpInside)
        rightView?.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    @objc
    private func togglePasswordText() {
        if eyePasswordButton.tag == 0 {
            eyePasswordButton.setImage(.eyeSlashIcon, for: .normal)
            eyePasswordButton.tag = 1
            isSecureTextEntry = false
        } else {
            eyePasswordButton.setImage(.eyeIcon, for: .normal)
            eyePasswordButton.tag = 0
            isSecureTextEntry = true
        }
    }
}

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.layer.shadowOpacity = 0.3
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.layer.shadowOpacity = 0
        }
    }
    
}

extension CustomTextField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
