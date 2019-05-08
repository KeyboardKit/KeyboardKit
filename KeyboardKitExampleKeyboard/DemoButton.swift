//
//  DemoButton.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

class DemoButton: KeyboardButtonView {
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController, distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        let isDark = keyboardAppearance == .dark
        backgroundColor = UIColor.black.withAlphaComponent(0.0001)
        buttonView?.backgroundColor = isDark ? .darkGray : .white
        image?.image = action.keyboardImage
        textLabel?.textColor = isDark ? .white : .black
        textLabel?.text = action.keyboardText
        width = action.keyboardWidth(for: distribution)
        addBadgeShadow()
    }
    
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 7 }
    }
    
    @IBOutlet weak var image: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
}
