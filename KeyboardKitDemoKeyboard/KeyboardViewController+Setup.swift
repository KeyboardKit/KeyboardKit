//
//  KeyboardViewController+Setup.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func setupDemoKeyboard() {
        keyboardStackView.removeAllArrangedSubviews()
        switch context.keyboardType {
        case .alphabetic, .numeric, .symbolic: setupSystemKeyboard()
        case .emojis: setupEmojiKeyboard()
        case .images: setupImageKeyboard()
        default: return
        }
    }
    
    func setupEmojiKeyboard() {
        let keyboard = EmojiKeyboard(in: self)
        let config = keyboard.gridConfig
        let view = KeyboardButtonRowCollectionView(id: "EmojiKeyboard", actions: keyboard.actions, configuration: config) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        let label = emojiCategoryTitleLabel
        emojiLabelUpdateAction = { label.text = keyboard.getCategory(at: view.persistedCurrentPageIndex)?.title ?? "" }
        view.panGestureRecognizer.addTarget(self, action: #selector(refreshEmojiCategoryLabel(_:)))
        keyboardStackView.addArrangedSubview(emojiCategoryTitleLabel)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
        emojiCollectionView = view
        emojiKeyboard = keyboard
        emojiLabelUpdateAction()
    }
    
    func setupImageKeyboard() {
        let keyboard = ImageKeyboard(in: self)
        let view = KeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: keyboard.gridConfig) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupSystemKeyboard() {
        let layout = context.keyboardLayoutProvider.keyboardLayout(for: context)
        let rows = buttonRows(for: layout.actionRows, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
}


// MARK: - Actions

@objc extension KeyboardViewController {
    
    /**
     For now, this pan action handler delays updating, since
     the gesture ends before the scroll view stops scrolling.
     */
    func refreshEmojiCategoryLabel(_ recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: emojiLabelUpdateAction)
    }
}
