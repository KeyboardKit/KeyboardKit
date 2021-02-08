//
//  KeyboardViewController+Keyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit
import UIKit

/**
 This extension sets up the different keyboards for the demo.
 
 `NOTE` This extension has a hack for adding an edge padding
 to the second row on English keyboards. This is just a hack
 to show how this can be done and must be generalized before
 something like this could be added to the core library.
 */
extension KeyboardViewController {
    
    func setupDemoKeyboard() {
        keyboardStackView.removeAllArrangedSubviews()
        switch keyboardContext.keyboardType {
        case .alphabetic, .numeric, .symbolic: setupSystemKeyboard()
        case .emojis: setupEmojiKeyboard()
        case .images: setupImageKeyboard()
        default: return
        }
    }
    
    func setupEmojiKeyboard() {
        let keyboard = EnhancedEmojiKeyboard(context: keyboardContext)
        let config = keyboard.gridConfig
        let view = HFloatingHeaderButtonCollectionView(id: "EnhancedEmojiKeyboard", categoryActions: keyboard.categoryActions, configuration: config, buttonCreator: { [unowned self] in return self.button(for: $0) })
        
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
        emojiCollectionView = view
        emojiKeyboard = keyboard
    }
    
    func setupImageKeyboard() {
        let keyboard = ImageKeyboard(in: self, context: keyboardContext)
        let view = UIKeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: keyboard.gridConfig) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupSystemKeyboard() {
        let layout = keyboardLayoutProvider.keyboardLayout(for: keyboardContext)
        let actions = buttonRows(for: layout.items)
        var rows = buttonRows(for: actions, distribution: .fillProportionally)
        rows.insert(autocompleteToolbar, at: 0)
        keyboardStackView.addArrangedSubviews(rows)
    }
}


private extension KeyboardViewController {
    
    func button(for action: KeyboardAction, distribution: UIStackView.Distribution = .equalSpacing) -> UIView {
        if action == .none { return UIKeyboardSpacerView(width: 10) }
        let view = DemoButton.fromNib(owner: self)
        view.setup(with: action, in: self, distribution: distribution)
        return view
    }
    
    func buttonRow(for row: KeyboardActions, index: Int = 0, distribution: UIStackView.Distribution) -> UIView {
        UIKeyboardButtonRow(actions: row, distribution: distribution) {
            button(for: $0, distribution: distribution)
        }
    }
    
    func buttonRows(for rows: KeyboardActionRows, distribution: UIStackView.Distribution) -> [UIView] {
        rows.enumerated().map { offset, row in
            let row = buttonRow(for: row, distribution: distribution)
            let insets = edgeInsets(atRow: offset)
            let view = UIView()
            view.addSubview(row, fill: true, insets: insets)
            return view
        }
    }
    
    func buttonRows(for rows: KeyboardLayoutItemRows) -> KeyboardActionRows {
        rows.map {
            $0.map { $0.action }
        }
    }
}

private extension KeyboardViewController {
    
    func edgeInsets(atRow row: Int) -> UIEdgeInsets {
        guard keyboardContext.locale.identifier.starts(with: "en") else { return .zero }
        guard row == 1 else { return .zero }
        let isIpad = keyboardContext.device.userInterfaceIdiom == .pad
        let inset = UIScreen.main.bounds.width * 0.05
        let left = inset
        let right = isIpad ? 0 : -inset
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
}


// MARK: - Actions

@objc extension KeyboardViewController {
    
    func refreshEmojiCategoryLabel(_ recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: emojiLabelUpdateAction)
    }
}


// MARK: - UIView Extensions

extension UIView {
    
    /**
     Add a subview with an option to adjust its anchords to
     make it fill its superview.
     */
    func addSubview(_ subview: UIView, fill: Bool, insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        guard fill else { return }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        subview.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
    }
}
