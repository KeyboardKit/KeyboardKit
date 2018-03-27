//
//  DemoCell.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2018-03-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

class DemoCell: UICollectionViewCell {
    
    
    // MARK: - Overrides
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        backgroundView = nil
        textLabel?.text = nil
    }
    
    
    // MARK: - Properties
    
    public fileprivate(set) var action: KeyboardAction?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 10 }
    }
    
    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
    
    
    // MARK: - Public Functions
    
    open func setup(with action: KeyboardAction, appearance: UIKeyboardAppearance, tintColor: UIColor) {
        buttonView?.alpha = action.isNone ? 0.01 : 1
        self.action = action
        setupBackground()
        setupButton(with: appearance)
        setupImage(with: action)
        setupTextLabel(with: action, tintColor: tintColor)
        addBadgeShadow()
    }
    
    open func setupBackground() {
        backgroundColor = UIColor.black.withAlphaComponent(0.0001)
    }
    
    open func setupButton(with appearance: UIKeyboardAppearance) {
        let isDark = appearance == .dark
        let color: UIColor = isDark ? UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1) : .white
        buttonView?.backgroundColor = color
    }
    
    open func setupImage(with action: KeyboardAction) {
        imageView?.image = action.keyboardImage
        imageView?.isHidden = imageView?.image == nil
    }
    
    open func setupTextLabel(with action: KeyboardAction, tintColor: UIColor) {
        textLabel?.textColor = tintColor
        textLabel?.text = action.title
    }
}
