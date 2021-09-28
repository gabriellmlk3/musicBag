//
//  CutomTextFieldView.swift
//  Music Bag
//
//  Created by Premier on 27/09/21.
//

import UIKit

class CutomTextFieldView: UIView {

    var textField: CustomTextField
    
    var alertMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    init(colorType: TextFieldColorType, type: TextFieldType, placeholder: String?) {
        self.textField = CustomTextField(colorType: colorType, type: type, placeholder: placeholder)
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        addSubview(alertMessageLabel)
        alertMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(13)
        }
    }
}
