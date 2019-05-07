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
    
    public override func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController) {
        super.setup(with: action, in: viewController)
        let noneAction = action == .none
        buttonView?.alpha = noneAction ? 0.01 : 1
        setupBackground()
        setupButton()
        setupImage(with: action)
        setupTextLabel(with: action)
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


private extension DemoButton {
    
    func setupBackground() {
        backgroundColor = UIColor.black.withAlphaComponent(0.0001)
    }
    
    func setupButton() {
        let isDark = keyboardAppearance == .dark
        let color: UIColor = isDark ? .darkGray : .white
        buttonView?.backgroundColor = color
    }
    
    func setupImage(with action: KeyboardAction) {
        image?.image = action.keyboardImage
        image?.isHidden = image?.image == nil
    }
    
    func setupTextLabel(with action: KeyboardAction) {
        let isDark = keyboardAppearance == .dark
        textLabel?.textColor = isDark ? .white : .black
        textLabel?.text = action.keyboardText
    }
}
