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
    
    
    // MARK: - Initialization
    
    convenience init(action: KeyboardAction, appearance: UIKeyboardAppearance, tintColor: UIColor) {
        self.init(frame: .zero)
        setup(with: action, appearance: appearance, tintColor: tintColor)
    }
    
    
    // MARK: - Setup
    
    public func setup(with action: KeyboardAction, appearance: UIKeyboardAppearance, tintColor: UIColor) {
        let noneAction = action == .none
        buttonView?.alpha = noneAction ? 0.01 : 1
        setupBackground()
        setupButton(with: appearance)
        setupImage(with: action)
        setupTextLabel(with: action, tintColor: tintColor)
        addBadgeShadow()
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 10 }
    }
    
    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
    
    
    // MARK: - Public Functions
    
    func setupBackground() {
        backgroundColor = UIColor.black.withAlphaComponent(0.0001)
    }
    
    func setupButton(with appearance: UIKeyboardAppearance) {
        let isDark = appearance == .dark
        let color: UIColor = isDark ? UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1) : .white
        buttonView?.backgroundColor = color
    }
    
    func setupImage(with action: KeyboardAction) {
        imageView?.image = action.keyboardImage
        imageView?.isHidden = imageView?.image == nil
    }
    
    func setupTextLabel(with action: KeyboardAction, tintColor: UIColor) {
        textLabel?.textColor = tintColor
        textLabel?.text = action.keyboardText
    }
}
