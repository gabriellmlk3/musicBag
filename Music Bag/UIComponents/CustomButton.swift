//
//  CustomButton.swift
//  Music Bag
//
//  Created by Premier on 27/09/21.
//

import UIKit

enum ButtonColorType {
    case dark
    case light
    case disable
    
    var backGoundColor: UIColor {
        switch self {
        case .dark:
            return .black1E2125
        case .light:
            return .white
        case .disable:
            return .systemGray
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .dark:
            return .white
        case .light:
            return .black1E2125
        case .disable:
            return .black1E2125
        }
    }
}

class CustomButton: UIButton {
    
    var colorType: ButtonColorType
    
    override var isEnabled: Bool {
        didSet {
            toggleButtonState()
        }
    }

    init(colorType: ButtonColorType, title: String) {
        self.colorType = colorType
        super.init(frame: .zero)
        layer.cornerRadius = 5
        backgroundColor = colorType.backGoundColor
        setTitleColor(colorType.textColor, for: .normal)
        setAttributedTitle(NSAttributedString(string: title,
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func toggleButtonState() {
        if isEnabled {
            backgroundColor = colorType.backGoundColor
        } else {
            backgroundColor = ButtonColorType.disable.backGoundColor
        }
    }
}
